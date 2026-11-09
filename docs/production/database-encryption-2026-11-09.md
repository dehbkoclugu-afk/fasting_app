# Database encryption

The local database (fasts, weight, meals, water, settings) is encrypted at rest
with SQLite3MultipleCiphers (ChaCha20), selected by the `hooks` section
of `pubspec.yaml`. The key is 32 random bytes in Android Keystore-backed storage
or the iOS Keychain. Code: `lib/data/database/database_encryption.dart`.

## Behaviour

| Situation | Result |
| --- | --- |
| New install | Encrypted from the first write. |
| Existing plaintext database | Copied, encrypted, verified (integrity and row counts), then atomically swapped in. |
| Crash or full disk during migration | Original stays usable; temporary copy is removed; retried next launch. |
| Key store fails, database still plaintext | Keeps working unencrypted; retried next launch. |
| Key store fails, database encrypted | Open fails, file untouched; works again once the key store recovers. |
| Key gone or wrong (for example restored backup) | File moved to `fasting_app.sqlite.unreadable`, app starts empty; "Delete all my data" removes the copy. |

## Known consequences

- **Android history does not follow the user to a new phone.** Auto Backup used
  to restore the plaintext database. Keystore keys cannot leave the device, so
  the database and key are excluded from backup and device transfer
  (`res/xml/backup_rules.xml`, `res/xml/data_extraction_rules.xml`). iOS keeps
  history through encrypted device backups (`first_unlock` Keychain item).
- Name, height, weight, target weight and age moved from SharedPreferences to
  the encrypted `settings` table, so they no longer follow the user to a new
  Android phone either. A preference value is removed only after the database
  holds it; if the database is unavailable the value stays in, or returns to,
  preferences and moves on the next launch.
- `last_crisis_hour`, `last_crisis_reason` and `isMale` were written but never
  read. They are no longer stored and are deleted from existing installs. The
  onboarding gender question is now unused.
- **Other preferences remain plaintext and backed up**: `crisis_support_count`,
  `selectedPlanId`, `safety_status` and the active fast state. The startup gate
  and the background notification task read some of these from preferences.
- Replacing the file does not securely erase old plaintext blocks on flash.
- Store listings and the privacy policy should mention the backup change.

## Maintenance

- `sqlite3` stays below 3.6.0: newer versions conflict with the `meta` version
  pinned by Flutter 3.38.10. Lift the cap when Flutter is upgraded.
- Regenerate drift code with `dart run build_runner build --force-jit`; the
  default AOT build script fails because `sqlite3` uses build hooks.
- `sqlcipher_flutter_libs` is end-of-life and must not be reintroduced.

## Verification

- `test/data/database_encryption_test.dart` runs against the real encrypted
  build: new database, migration, crash leftovers, failed migration, lost and
  mismatched keys, key store outages.
- `tool/android_smoke.sh` seeds an onboarded user with a plaintext database on
  an emulator and checks that it migrates and reopens.
- Not yet verified: iOS device, signed release build, upgrade from the Play
  Store build on a real phone.
