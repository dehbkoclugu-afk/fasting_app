# FastTrack — 100-stage production bug-control protocol

Audit started: 2026-08-23 (Europe/Istanbul)  
Baseline: `main@9e5c938689a588572686a7da4ab0e7dc86bbef41`  
Audit branch: `codex/production-bug-audit-100`

## Rules

- Every check must end as **PASS**, **FIXED**, **FAIL**, **BLOCKED**, **WARN**, or **MANUAL** with evidence.
- **P0**: purchase, data-loss, launch, signing, missing-network, or security defect. Stop release.
- **P1**: broken core flow, wrong localization, inaccessible CTA, severe crop/overlap. Stop release unless fixed.
- **P2**: degraded secondary flow or visual defect. Must be scheduled before release sign-off.
- A GitHub Actions quota failure is infrastructure evidence only; it never counts as a passing code test.
- Release sign-off requires zero open P0/P1 items and a signed real-device build.

## Initial findings

- **P0 risk closed on audit branch:** the app-level release manifest did not explicitly declare `INTERNET`. A dependency may have supplied it in the merged manifest, so this is not proof that production networking was absent; the permission is now explicit and regression-guarded.
- **P1 fixed on audit branch:** Android 13+ notification permission was absent from the release manifest, and onboarding kept notifications enabled after denial/skip. The manifest and saved setting now follow the real permission result.
- **CI-control fixed on audit branch:** PR commits were eligible for both `push` and `pull_request` Android workflows, wasting quota.
- Localization inventory: 32 locale files × 514 messages; no missing/extra keys, placeholder mismatches, or locale-metadata mismatches.
- Artwork inventory: 87 Dart files scanned, 74 referenced assets found, zero missing; all five phase light/dark pairs and twelve quick-meal artworks exist.

## Current tally (updated 2026-11-11)

- PASS: 77
- FIXED: 6
- PENDING: 3
- MANUAL: 13
- WARN: 1

### Release identity

| # | Check | Status | Evidence / next action |
|---:|---|---|---|
| 1 | Freeze audited main commit | **PASS** | release candidate = fix/release-blockers@663871e (PR #73) |
| 2 | Record semantic version and build number | **PASS** | 1.3.0+31; build 30 was used by the iOS review-video branch |
| 3 | Match Android applicationId and namespace | **PASS** | com.dehbkoclugu.fasttrack |
| 4 | Match iOS bundle identifier in release workflow | **PASS** | com.dehbkoclugu.fasttrack |
| 5 | Keep signing files and release.json out of git | **PASS** | .gitignore guards all four |
| 6 | Document production build inputs | **PASS** | RELEASE_SETUP.md |
| 7 | Run Android CI pipeline | **PASS** | Android CI run on 663871e passed (analyze, tests, AAB) |
| 8 | Prevent duplicate push + PR workflow runs | **FIXED** | branch restricts push/PR to main |
| 9 | Pin Flutter toolchain used for release | **PASS** | Flutter 3.38.10 |
| 10 | Review stale open PRs before any merge | **WARN** | PR #8 and #10 still open since August; unrelated to the release, close or leave |

### Build and platform

| # | Check | Status | Evidence / next action |
|---:|---|---|---|
| 11 | Parse pubspec and retain lockfile | **PASS** | pubspec.yaml and pubspec.lock present |
| 12 | Generate localization sources | **PASS** | CI generates localization on Flutter 3.38.10 |
| 13 | Run flutter analyze | **PASS** | CI analyze on 663871e: no errors or warnings |
| 14 | Run full flutter test | **PASS** | CI full test suite on 663871e passed |
| 15 | Build signed Android AAB | **PENDING** | Codemagic production AAB after the phone test |
| 16 | Build installable release APK | **PASS** | sideload-apk workflow builds release APKs (throwaway key) |
| 17 | Verify AAB signer certificate | **PENDING** | Codemagic verifies the upload certificate when it builds the AAB |
| 18 | Declare INTERNET in release manifest | **FIXED** | added to main manifest |
| 19 | Declare POST_NOTIFICATIONS in release manifest | **FIXED** | added to main manifest |
| 20 | Fail preflight when release permissions regress | **FIXED** | release_check.ps1 + regression test |

### Localization

| # | Check | Status | Evidence / next action |
|---:|---|---|---|
| 21 | Inventory every ARB locale | **PASS** | 32 locale files |
| 22 | Match every locale to English message set | **PASS** | 514/514 keys in all locales |
| 23 | Reject extra locale-only message keys | **PASS** | 0 extra keys |
| 24 | Preserve all placeholders | **PASS** | 0 placeholder mismatches |
| 25 | Match @@locale metadata to file names | **PASS** | 0 metadata mismatches |
| 26 | Use selected app locale for journey duration | **PASS** | merged in #52 |
| 27 | Use locale-aware percentage placement | **PASS** | merged in #52 |
| 28 | Keep journey_next placeholder order locale-owned | **PASS** | {time}/{phase} valid in all locales |
| 29 | Keep early-stop title/message in every locale | **PASS** | completed by #44 |
| 30 | Verify RTL screens on Arabic/Hebrew devices | **MANUAL** | real-device visual gate |

### Artwork and responsive UI

| # | Check | Status | Evidence / next action |
|---:|---|---|---|
| 31 | Resolve every referenced editorial asset | **PASS** | 74/74 references exist |
| 32 | Bundle all editorial asset directories | **PASS** | pubspec entries present |
| 33 | Provide light/dark art for every phase | **PASS** | 5/5 physical pairs |
| 34 | Render Anabolic art in a filled 16:9 slot | **FIXED** | merged in #52 |
| 35 | Keep artwork theme resolver on light/dark pair | **PASS** | covered by existing test |
| 36 | Keep twelve quick-meal artworks | **PASS** | 12 dark assets plus light pairs |
| 37 | Review badge artwork contain-fit intentionally | **MANUAL** | contain preserves uncropped badge art |
| 38 | Review completion artwork contain-fit intentionally | **MANUAL** | device screenshot required |
| 39 | Verify launcher/adaptive/monochrome icons | **PASS** | adaptive icon has background, inset foreground and monochrome; all densities present |
| 40 | Screenshot all core screens at 320/360/412 dp | **MANUAL** | real-device matrix |

### Timer and session state

| # | Check | Status | Evidence / next action |
|---:|---|---|---|
| 41 | Start exactly one active session | **PASS** | timer_provider_test: concurrent starts create exactly one active session |
| 42 | Reject repeated start while start is pending | **PASS** | timer_provider_test: start stays guarded until optional services finish |
| 43 | Persist start time and target duration | **PASS** | timer_provider_test: restore resumes an unfinished session |
| 44 | Restore active session after process death | **PASS** | timer_provider_test: restore resumes an unfinished session |
| 45 | Finalize overdue restored session once | **PASS** | timer_provider_test: restore finalizes an overdue session exactly once |
| 46 | Make duplicate finish idempotent | **PASS** | timer_provider_test: duplicate finish calls do not rewrite history |
| 47 | Record early stop as incomplete | **PASS** | timer_provider_test: early stop is persisted as incomplete |
| 48 | Record target-time stop as complete | **PASS** | timer_provider_test: target-time stop is persisted as complete |
| 49 | Keep session when optional start services fail | **PASS** | timer_provider_test: optional start failure keeps the active database session |
| 50 | Clear widget when optional stop services fail | **PASS** | timer_provider_test: optional stop failure still clears the widget |

### Metabolic journey

| # | Check | Status | Evidence / next action |
|---:|---|---|---|
| 51 | Map 0–4h to Anabolic | **PASS** | phase constants |
| 52 | Map 4–8h to Catabolic | **PASS** | phase constants |
| 53 | Map 8–12h to Fat Burning | **PASS** | phase constants |
| 54 | Map 12–18h to Ketosis | **PASS** | phase constants |
| 55 | Map 18h+ to Autophagy | **PASS** | phase constants |
| 56 | Hide phases outside selected plan | **PASS** | fasting_ring_test: shows only metabolic phases inside the selected plan |
| 57 | Keep phase marker hit targets on-screen | **MANUAL** | markers sit on the ring; check tap targets on a 320 dp phone |
| 58 | Clamp progress to 0–100% | **PASS** | journey clamp |
| 59 | Calculate next-phase remaining time correctly | **PASS** | metabolic_journey_test: next-phase countdown and plan boundary |
| 60 | Verify phase card in all themes/locales | **MANUAL** | screenshot matrix |

### Premium and purchases

| # | Check | Status | Evidence / next action |
|---:|---|---|---|
| 61 | Initialize RevenueCat without crashing launch | **PASS** | configure failure is retryable |
| 62 | Use premium entitlement identifier | **PASS** | premium |
| 63 | Show current non-empty offering | **PASS** | service implementation |
| 64 | Fallback to another non-empty offering | **PASS** | service implementation |
| 65 | Support custom RevenueCat package types | **PASS** | paywall_screen_test: custom package type |
| 66 | Enable purchase CTA when packages load | **PASS** | paywall_screen_test: enabled purchase button |
| 67 | Preselect yearly plan and savings correctly | **PASS** | paywall_screen_test: yearly preselected with savings |
| 68 | Offer retry when products are unavailable | **PASS** | paywall_screen_test: retry when no products load |
| 69 | Restore purchases and update entitlement | **PASS** | subscription_provider_test: restore guards, verified restore, stale refresh; store test in #70 |
| 70 | Complete real Play license-tester purchase | **MANUAL** | mandatory production-device gate |

### Meals, AI and quotas

| # | Check | Status | Evidence / next action |
|---:|---|---|---|
| 71 | Hide scanner when GEMINI_API_KEY is absent | **PASS** | BuildConfig gate |
| 72 | Reject release build without Gemini key | **PASS** | Codemagic build gate |
| 73 | Recover Android camera result after process death | **PASS** | main startup recovery |
| 74 | Recognize JPEG/PNG/WebP signatures | **PASS** | food_scan_provider_test: JPEG, PNG and WebP signatures |
| 75 | Recognize Samsung HEIC metadata/signature | **PASS** | food_scan_provider_test: Samsung HEIC |
| 76 | Preserve photo on retry | **PASS** | food_scan_screen_test: recovered photo starts once |
| 77 | Recalculate macros after editing item | **PASS** | food_scan_provider_test: editing an item re-totals |
| 78 | Recalculate macros after deleting item | **PASS** | food_scan_provider_test: removing an item drops it from totals |
| 79 | Enforce and persist daily scan quota | **PASS** | food_scan_provider_test: daily cap, persistence, midnight refresh |
| 80 | Declare photo processing in store privacy forms | **MANUAL** | draft in store-privacy-declarations-2026-11-11.md; scanning ships on in 1.3.0 |

### Notifications, background and widget

| # | Check | Status | Evidence / next action |
|---:|---|---|---|
| 81 | Initialize notification plugin safely | **PASS** | initialize() wraps plugin setup in try/catch; runs as an optional service |
| 82 | Request notification permission on Android 13+ | **FIXED** | manifest enables runtime request; onboarding persists denial/skip as disabled |
| 83 | Use selected locale in scheduled notifications | **PASS** | saved locale lookup |
| 84 | Schedule halfway reminder only in future | **PASS** | service guard |
| 85 | Schedule phase reminders inside fasting window | **PASS** | service guard |
| 86 | Schedule completion reminder only in future | **PASS** | service guard |
| 87 | Avoid notification ID collisions | **PASS** | separate ID ranges |
| 88 | Cancel scheduled reminders when fasting stops | **PASS** | service implementation |
| 89 | Restore/update background ongoing notification | **MANUAL** | real-device battery test |
| 90 | Update and clear home-screen widget reliably | **MANUAL** | real-device widget test |

### Data, security and store acceptance

| # | Check | Status | Evidence / next action |
|---:|---|---|---|
| 91 | Keep database migration path upgrade-safe | **PASS** | schemaVersion 1 unchanged since main; encryption migration covered by database_encryption_test and the emulator upgrade test |
| 92 | Prevent duplicate history rows | **PASS** | timer tests: one session per start, finalize once, duplicate finish |
| 93 | Handle database close/corruption gracefully | **PASS** | restore after database close; lost/mismatched key and failed migration tests |
| 94 | Keep billable Gemini key out of source | **PASS** | no fallback constant |
| 95 | Restrict Gemini key and quota in Google Cloud | **MANUAL** | cloud-console gate |
| 96 | Use production AdMob application/unit IDs | **PASS** | Android production IDs present |
| 97 | Verify privacy and terms URLs return 200 | **PASS** | 2026-11-11: /privacy/ and /terms/ on fasting-app-mauve.vercel.app return 200 |
| 98 | Verify store icon, feature graphic and screenshots | **MANUAL** | Play Console gate |
| 99 | Run clean install and upgrade from production build | **MANUAL** | signed APK/internal track |
| 100 | Sign off release only with zero P0/P1 failures | **PENDING** | final protocol gate |

