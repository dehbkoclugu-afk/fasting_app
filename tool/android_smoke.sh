#!/usr/bin/env bash
set -euo pipefail

package_name=com.dehbkoclugu.fasttrack
adb install -r /tmp/fasttrack-debug.apk

package_dump=$(mktemp)
adb shell dumpsys package "$package_name" > "$package_dump"
for receiver in ScheduledNotificationReceiver ScheduledNotificationBootReceiver; do
  if ! grep -q "com.dexterous.flutterlocalnotifications.$receiver" "$package_dump"; then
    echo "Missing installed notification receiver: $receiver" >&2
    exit 1
  fi
done
if ! grep -q 'android.permission.RECEIVE_BOOT_COMPLETED' "$package_dump"; then
  echo 'Missing installed boot permission' >&2
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

log_file=$(mktemp)
adb logcat -d -t 20000 > "$log_file"
if grep -A 8 'FATAL EXCEPTION' "$log_file" | grep -q "Process: $package_name"; then
  grep -A 16 'FATAL EXCEPTION' "$log_file" | tail -20
  exit 1
fi
echo 'PASS: installed receivers and boot permission; app launched and relaunched without a fatal exception.'
