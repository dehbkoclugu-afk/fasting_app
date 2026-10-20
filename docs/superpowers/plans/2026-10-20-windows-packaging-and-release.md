# Windows Packaging and Release Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Package the completed social funnel as a dependable Windows desktop launch experience with setup guidance, backup/restore, and safe live-verification tooling.

**Architecture:** PyInstaller builds one signed-ready application directory containing the local server, templates, fonts, and launcher. A first-run wizard creates the workspace and database, while diagnostics verify FFmpeg, writable storage, credential vault, account capabilities, and localhost availability before scheduling starts.

**Tech Stack:** Python 3.13, PyInstaller, FastAPI/Uvicorn, keyring, pytest, PowerShell test scripts for CI only

**Spec:** `docs/superpowers/specs/2026-10-20-multilingual-social-publishing-funnel-design.md`

## Global Constraints

- This plan depends on the core, Meta, and TikTok plans.
- The user launches the product without opening a terminal.
- Bind the server to `127.0.0.1` only and choose a free port deterministically.
- Never package live credentials, developer secrets, campaign databases, or user media.
- Backup and restore must not export credential-vault secrets.
- Live verification requires the user to select one exact draft and destination.

## Review Focus

- A Windows username or workspace path containing Turkish characters and spaces must work; Tasks 1 and 2 test this.
- A port already in use must select another allowed localhost port and open the correct URL; Task 1 tests this.
- Restoring a backup over a newer schema must stop with an explanation rather than corrupt data; Task 2 tests this.
- An installed FFmpeg with an unexpected version string must be capability-tested, not rejected by string comparison; Task 1 tests this.
- Closing the launcher while a post is uploading must request graceful shutdown and preserve the claimed job for reconciliation; Task 1 tests this.

---

### Task 1: Launcher, diagnostics, and graceful shutdown

**Files:**
- Create: `social_funnel/src/social_funnel/windows/launcher.py`
- Create: `social_funnel/src/social_funnel/windows/diagnostics.py`
- Create: `social_funnel/tests/windows/test_launcher.py`
- Create: `social_funnel/tests/windows/test_diagnostics.py`

**Interfaces:**
- Consumes: web app factory, scheduler lifecycle, configured workspace, vault, and renderer.
- Produces: `launch() -> int`, `find_local_port(range) -> int`, `run_diagnostics() -> DiagnosticReport`, and graceful `shutdown()`.

- [ ] **Step 1: Write failing launcher and diagnostic tests**

Cover paths with spaces/diacritics, occupied port fallback, browser URL correctness, localhost-only binding, FFmpeg capability probe, unwritable workspace, unavailable vault, incomplete account setup, and graceful shutdown during an upload.

- [ ] **Step 2: Run focused tests and verify failure**

Run: `python -m pytest social_funnel/tests/windows/test_launcher.py social_funnel/tests/windows/test_diagnostics.py -v`
Expected: FAIL because Windows modules do not exist.

- [ ] **Step 3: Implement launcher and diagnostics**

Open the default browser only after the local health endpoint responds, display actionable failures in a native message box, and give the orchestrator a bounded graceful-shutdown window.

- [ ] **Step 4: Run focused tests**

Run: `python -m pytest social_funnel/tests/windows/test_launcher.py social_funnel/tests/windows/test_diagnostics.py -v`
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add social_funnel/src/social_funnel/windows social_funnel/tests/windows
git commit -m "feat: add Windows launcher and diagnostics"
```

### Task 2: First-run setup, backup, and restore

**Files:**
- Create: `social_funnel/src/social_funnel/setup/service.py`
- Create: `social_funnel/src/social_funnel/backup/service.py`
- Create: `social_funnel/src/social_funnel/web/templates/setup.html`
- Test: `social_funnel/tests/setup/test_setup.py`
- Test: `social_funnel/tests/backup/test_backup.py`

**Interfaces:**
- Consumes: database initializer, campaign loader, account repository, and workspace settings.
- Produces: `initialize_workspace(path)`, `create_backup(destination) -> Path`, and `restore_backup(path)`.

- [ ] **Step 1: Write failing setup and backup tests**

Assert first run imports 30/90/360 content counts, rerun is idempotent, Unicode paths work, backup contains database/config/media manifest but no secrets, checksum mismatch blocks restore, and newer-schema restore is rejected without modifying current data.

- [ ] **Step 2: Run focused tests and verify failure**

Run: `python -m pytest social_funnel/tests/setup social_funnel/tests/backup -v`
Expected: FAIL because setup and backup modules do not exist.

- [ ] **Step 3: Implement setup, backup, and transactional restore**

Restore into a temporary sibling workspace, validate schema/checksums, then swap only after validation; keep the prior workspace as a recoverable backup.

- [ ] **Step 4: Run focused tests**

Run: `python -m pytest social_funnel/tests/setup social_funnel/tests/backup -v`
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add social_funnel/src/social_funnel/setup social_funnel/src/social_funnel/backup social_funnel/src/social_funnel/web/templates/setup.html social_funnel/tests/setup social_funnel/tests/backup
git commit -m "feat: add social funnel setup and backups"
```

### Task 3: PyInstaller build and clean-machine smoke test

**Files:**
- Create: `social_funnel/packaging/social-funnel.spec`
- Create: `social_funnel/packaging/build.ps1`
- Create: `social_funnel/packaging/smoke-test.ps1`
- Modify: `.gitignore`
- Test: `social_funnel/tests/packaging/test_bundle_manifest.py`

**Interfaces:**
- Consumes: completed application and assets.
- Produces: `social_funnel/dist/FastTrack Social Funnel/` build directory and smoke-test report.

- [ ] **Step 1: Write failing bundle-manifest test**

Assert required templates/fonts/catalog files are declared, forbidden secrets/databases/user media are absent, and the executable entry point is `social_funnel.windows.launcher:launch`.

- [ ] **Step 2: Run the focused test and verify failure**

Run: `python -m pytest social_funnel/tests/packaging/test_bundle_manifest.py -v`
Expected: FAIL because packaging files do not exist.

- [ ] **Step 3: Implement reproducible packaging scripts**

Create a virtual environment, install the locked project, run the full test suite, build with PyInstaller, and emit SHA-256 checksums; scripts must stop on the first failure.

- [ ] **Step 4: Build and run the smoke test**

Run: `powershell -ExecutionPolicy Bypass -File social_funnel/packaging/build.ps1`
Expected: tests pass and the application directory is created.

Run: `powershell -ExecutionPolicy Bypass -File social_funnel/packaging/smoke-test.ps1`
Expected: launcher health check, 30/90/360 counts, render sample, pause/resume, and clean shutdown all pass without external publication.

- [ ] **Step 5: Commit**

```bash
git add .gitignore social_funnel/packaging social_funnel/tests/packaging
git commit -m "build: package social funnel for Windows"
```

### Task 4: Operator guide and opt-in live verification

**Files:**
- Create: `social_funnel/README.md`
- Create: `social_funnel/docs/account-setup.md`
- Create: `social_funnel/docs/operator-guide.md`
- Create: `social_funnel/src/social_funnel/verification/live_check.py`
- Test: `social_funnel/tests/verification/test_live_check.py`

**Interfaces:**
- Consumes: account capabilities, validators, publishers, and audit repository.
- Produces: setup documentation and `prepare_live_check(job_id, account_id) -> LiveCheckSummary`; actual send remains a separate explicit UI action.

- [ ] **Step 1: Write failing live-check tests**

Assert the summary names the exact account/platform/locale/content revision, rejects non-draft or invalid jobs, requires explicit confirmation immediately before send, and cannot select multiple destinations.

- [ ] **Step 2: Run the focused test and verify failure**

Run: `python -m pytest social_funnel/tests/verification/test_live_check.py -v`
Expected: FAIL because verification tooling does not exist.

- [ ] **Step 3: Implement documentation and live-check preparation**

Document creation and connection of all twelve surfaces, Meta/TikTok app review limitations, automatic versus approval mode, pause/recovery, backups, and manual publishing fallback.

- [ ] **Step 4: Run the full offline verification suite**

Run: `python -m pytest social_funnel/tests -v`
Expected: PASS with production network calls blocked.

- [ ] **Step 5: Commit**

```bash
git add social_funnel/README.md social_funnel/docs social_funnel/src/social_funnel/verification social_funnel/tests/verification
git commit -m "docs: add social funnel operations and verification"
```

