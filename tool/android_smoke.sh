#!/usr/bin/env bash
set -euo pipefail

package_name=com.dehbkoclugu.fasttrack
adb install -r /tmp/fasttrack-debug.apk

adb shell pm path "$package_name" | grep -q "package:"
aapt_binary=$(find "$ANDROID_HOME/build-tools" -maxdepth 2 -type f -name aapt | sort -V | tail -1)
if [[ -z "$aapt_binary" ]]; then
  echo 'Android aapt binary is unavailable' >&2
  exit 1
fi
manifest_dump=$(mktemp)
"$aapt_binary" dump xmltree /tmp/fasttrack-debug.apk AndroidManifest.xml > "$manifest_dump"
for receiver in ScheduledNotificationReceiver ScheduledNotificationBootReceiver; do
  if ! grep -Fq "com.dexterous.flutterlocalnotifications.$receiver" "$manifest_dump"; then
    echo "Missing APK notification receiver: $receiver" >&2
    exit 1
  fi
done
if ! grep -Fq 'android.permission.RECEIVE_BOOT_COMPLETED' "$manifest_dump"; then
  echo 'Missing APK boot permission' >&2
  exit 1
fi

adb logcat -c
for launch in 1 2; do
  adb shell am start -n "$package_name/.MainActivity"
  running=false
  for attempt in $(seq 1 30); do
    if adb shell pidof "$package_name" | grep -q '[0-9]'; then
      running=true
      break
    fi
    sleep 2
  done
  if [[ "$running" != true ]]; then
    echo "App did not stay running after launch $launch" >&2
    exit 1
  fi
  sleep 5
  if [[ "$launch" == 1 ]]; then
    adb shell am force-stop "$package_name"
  fi
done

# Upgrade path: an onboarded user whose database predates encryption. The native
# SQLite build and the Keystore can only be proven on Android itself.
db_path=app_flutter/fasting_app.sqlite
smoke_marker=smoke-plaintext-marker
plaintext_db=$(mktemp)
python3 - "$plaintext_db" "$smoke_marker" <<'PYTHON'
import sqlite3
import sys

db = sqlite3.connect(sys.argv[1])
db.execute('CREATE TABLE smoke_marker (value TEXT)')
db.execute('INSERT INTO smoke_marker VALUES (?)', (sys.argv[2],))
db.commit()
db.close()
PYTHON
adb shell pm clear "$package_name"
adb exec-in run-as "$package_name" sh -c "mkdir -p app_flutter && cat > $db_path" < "$plaintext_db"
adb shell "run-as $package_name sh -c 'mkdir -p shared_prefs && cat > shared_prefs/FlutterSharedPreferences.xml'" <<'XML'
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <boolean name="flutter.onboardingCompleted" value="true" />
    <string name="flutter.safety_status">cleared</string>
</map>
XML
if [[ "$(adb exec-out run-as "$package_name" head -c 15 "$db_path")" != 'SQLite format 3' ]]; then
  echo 'Seeded database should start as plaintext' >&2
  exit 1
fi

adb logcat -c
adb shell am start -n "$package_name/.MainActivity"
encrypted=false
for attempt in $(seq 1 30); do
  if [[ "$(adb exec-out run-as "$package_name" head -c 15 "$db_path")" != 'SQLite format 3' ]]; then
    encrypted=true
    break
  fi
  sleep 2
done
if [[ "$encrypted" != true ]]; then
  adb logcat -d -t 2000 | grep -E 'flutter|Database' | tail -30 || true
  echo 'Database was not encrypted after launch' >&2
  exit 1
fi
sleep 3
if adb exec-out run-as "$package_name" cat "$db_path" | grep -aq "$smoke_marker"; then
  echo 'Plaintext content survived in the encrypted database' >&2
  exit 1
fi
if adb exec-out run-as "$package_name" ls app_flutter | grep -q 'encrypting\|unreadable'; then
  echo 'Migration left a temporary or unreadable database behind' >&2
  exit 1
fi
adb shell am force-stop "$package_name"
adb shell am start -n "$package_name/.MainActivity"
sleep 8
if ! adb shell pidof "$package_name" | grep -q '[0-9]'; then
  echo 'App did not reopen its encrypted database' >&2
  exit 1
fi

log_file=$(mktemp)
adb logcat -d -t 20000 > "$log_file"
if grep -A 8 'FATAL EXCEPTION' "$log_file" | grep -q "Process: $package_name"; then
  grep -A 16 'FATAL EXCEPTION' "$log_file" | tail -20
  exit 1
fi
if grep -E 'Database (key|encryption)|file is not a database' "$log_file"; then
  echo 'Database encryption reported a problem' >&2
  exit 1
fi
echo 'PASS: installed receivers and boot permission; app launched and relaunched without a fatal exception; plaintext database migrated and reopened encrypted.'
