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

- **P0 fixed on audit branch:** Android release manifest lacked `INTERNET`; debug/profile had it, release did not.
- **P1 fixed on audit branch:** Android 13+ notification permission was absent from the release manifest.
- **CI-control fixed on audit branch:** PR commits were eligible for both `push` and `pull_request` Android workflows, wasting quota.
- Localization inventory: 32 locale files × 514 messages; no missing/extra keys, placeholder mismatches, or locale-metadata mismatches.
- Artwork inventory: 87 Dart files scanned, 74 referenced assets found, zero missing; all five phase light/dark pairs and twelve quick-meal artworks exist.

## Current tally

- PASS: 43
- BLOCKED: 6
- FIXED: 6
- WARN: 1
- PENDING: 34
- MANUAL: 10

### Release identity

| # | Check | Status | Evidence / next action |
|---:|---|---|---|
| 1 | Freeze audited main commit | **PASS** | main = 9e5c938 |
| 2 | Record semantic version and build number | **PASS** | 1.2.6+19 |
| 3 | Match Android applicationId and namespace | **PASS** | com.dehbkoclugu.fasttrack |
| 4 | Match iOS bundle identifier in release workflow | **PASS** | com.dehbkoclugu.fasttrack |
| 5 | Keep signing files and release.json out of git | **PASS** | .gitignore guards all four |
| 6 | Document production build inputs | **PASS** | RELEASE_SETUP.md |
| 7 | Run Android CI pipeline | **BLOCKED** | GitHub Actions quota; job never started |
| 8 | Prevent duplicate push + PR workflow runs | **FIXED** | branch restricts push/PR to main |
| 9 | Pin Flutter toolchain used for release | **PASS** | Flutter 3.38.10 |
| 10 | Review stale open PRs before any merge | **WARN** | PR #8 and #10 remain open |

### Build and platform

| # | Check | Status | Evidence / next action |
|---:|---|---|---|
| 11 | Parse pubspec and retain lockfile | **PASS** | pubspec.yaml and pubspec.lock present |
| 12 | Generate localization sources | **BLOCKED** | requires Flutter runtime/Codemagic |
| 13 | Run flutter analyze | **BLOCKED** | requires Flutter runtime/Codemagic |
| 14 | Run full flutter test | **BLOCKED** | requires Flutter runtime/Codemagic |
| 15 | Build signed Android AAB | **BLOCKED** | Codemagic/device release gate |
| 16 | Build installable release APK | **BLOCKED** | Codemagic/device release gate |
| 17 | Verify AAB signer certificate | **PENDING** | Codemagic already has verification step |
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
| 39 | Verify launcher/adaptive/monochrome icons | **PENDING** | asset existence and rendered icon mask |
| 40 | Screenshot all core screens at 320/360/412 dp | **MANUAL** | real-device matrix |

### Timer and session state

| # | Check | Status | Evidence / next action |
|---:|---|---|---|
| 41 | Start exactly one active session | **PENDING** | existing provider regression test |
| 42 | Reject repeated start while start is pending | **PENDING** | existing provider regression test |
| 43 | Persist start time and target duration | **PENDING** | provider/database inspection + test |
| 44 | Restore active session after process death | **PENDING** | existing regression test |
| 45 | Finalize overdue restored session once | **PENDING** | existing regression test |
| 46 | Make duplicate finish idempotent | **PENDING** | existing regression test |
| 47 | Record early stop as incomplete | **PENDING** | existing regression test |
| 48 | Record target-time stop as complete | **PENDING** | existing regression test |
| 49 | Keep session when optional start services fail | **PENDING** | existing regression test |
| 50 | Clear widget when optional stop services fail | **PENDING** | existing regression test |

### Metabolic journey

| # | Check | Status | Evidence / next action |
|---:|---|---|---|
| 51 | Map 0–4h to Anabolic | **PASS** | phase constants |
| 52 | Map 4–8h to Catabolic | **PASS** | phase constants |
| 53 | Map 8–12h to Fat Burning | **PASS** | phase constants |
| 54 | Map 12–18h to Ketosis | **PASS** | phase constants |
| 55 | Map 18h+ to Autophagy | **PASS** | phase constants |
| 56 | Hide phases outside selected plan | **PENDING** | fasting_ring widget test |
| 57 | Keep phase marker hit targets on-screen | **PENDING** | fasting_ring widget test |
| 58 | Clamp progress to 0–100% | **PASS** | journey clamp |
| 59 | Calculate next-phase remaining time correctly | **PENDING** | formatter + boundary tests |
| 60 | Verify phase card in all themes/locales | **MANUAL** | screenshot matrix |

### Premium and purchases

| # | Check | Status | Evidence / next action |
|---:|---|---|---|
| 61 | Initialize RevenueCat without crashing launch | **PASS** | configure failure is retryable |
| 62 | Use premium entitlement identifier | **PASS** | premium |
| 63 | Show current non-empty offering | **PASS** | service implementation |
| 64 | Fallback to another non-empty offering | **PASS** | service implementation |
| 65 | Support custom RevenueCat package types | **PENDING** | existing paywall test |
| 66 | Enable purchase CTA when packages load | **PENDING** | existing paywall test |
| 67 | Preselect yearly plan and savings correctly | **PENDING** | existing paywall test |
| 68 | Offer retry when products are unavailable | **PENDING** | existing paywall test |
| 69 | Restore purchases and update entitlement | **PENDING** | provider/device test |
| 70 | Complete real Play license-tester purchase | **MANUAL** | mandatory production-device gate |

### Meals, AI and quotas

| # | Check | Status | Evidence / next action |
|---:|---|---|---|
| 71 | Hide scanner when GEMINI_API_KEY is absent | **PASS** | BuildConfig gate |
| 72 | Reject release build without Gemini key | **PASS** | Codemagic build gate |
| 73 | Recover Android camera result after process death | **PASS** | main startup recovery |
| 74 | Recognize JPEG/PNG/WebP signatures | **PENDING** | existing provider test |
| 75 | Recognize Samsung HEIC metadata/signature | **PENDING** | existing provider test |
| 76 | Preserve photo on retry | **PENDING** | existing provider test |
| 77 | Recalculate macros after editing item | **PENDING** | existing provider test |
| 78 | Recalculate macros after deleting item | **PENDING** | existing provider test |
| 79 | Enforce and persist daily scan quota | **PENDING** | existing provider tests |
| 80 | Declare photo processing in store privacy forms | **MANUAL** | Play/App Store console gate |

### Notifications, background and widget

| # | Check | Status | Evidence / next action |
|---:|---|---|---|
| 81 | Initialize notification plugin safely | **PENDING** | service/device test |
| 82 | Request notification permission on Android 13+ | **FIXED** | manifest now enables runtime request |
| 83 | Use selected locale in scheduled notifications | **PASS** | saved locale lookup |
| 84 | Schedule halfway reminder only in future | **PASS** | service guard |
| 85 | Schedule phase reminders inside fasting window | **PASS** | service guard |
| 86 | Schedule completion reminder only in future | **PASS** | service guard |
| 87 | Avoid notification ID collisions | **PASS** | separate ID ranges |
| 88 | Cancel scheduled reminders when fasting stops | **PASS** | service implementation |
| 89 | Restore/update background ongoing notification | **PENDING** | real-device battery test |
| 90 | Update and clear home-screen widget reliably | **PENDING** | real-device widget test |

### Data, security and store acceptance

| # | Check | Status | Evidence / next action |
|---:|---|---|---|
| 91 | Keep database migration path upgrade-safe | **PENDING** | schema/version audit |
| 92 | Prevent duplicate history rows | **PENDING** | provider/database tests |
| 93 | Handle database close/corruption gracefully | **PENDING** | existing restore test + fault injection |
| 94 | Keep billable Gemini key out of source | **PASS** | no fallback constant |
| 95 | Restrict Gemini key and quota in Google Cloud | **MANUAL** | cloud-console gate |
| 96 | Use production AdMob application/unit IDs | **PASS** | Android production IDs present |
| 97 | Verify privacy and terms URLs return 200 | **PENDING** | external endpoint check |
| 98 | Verify store icon, feature graphic and screenshots | **MANUAL** | Play Console gate |
| 99 | Run clean install and upgrade from production build | **MANUAL** | signed APK/internal track |
| 100 | Sign off release only with zero P0/P1 failures | **PENDING** | final protocol gate |

