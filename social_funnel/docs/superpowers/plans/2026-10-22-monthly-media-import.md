# Monthly Media Import Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Let the Windows EXE safely import a monthly media ZIP, preview and activate its slots, persist the selection, and feed the exact approved files to ZIP export and platform publishers.

**Architecture:** A focused `media` package parses and validates an archive into immutable batch files. SQLite stores batches, slots, and the active batch; a resolver supplies imported assets before deterministic image fallback and never generates video fallback. FastAPI exposes preflight, activation, coverage, replacement, and rollback screens, while existing orchestrator/export code consumes the resolver.

**Tech Stack:** Python 3.13, FastAPI/Jinja, SQLite, Pillow, FFmpeg/ffprobe, pytest.

**Spec:** `docs/HANDOFF-2026-10-22.md` sections 5, 6, 8, 9, 14, and 15.

## Global Constraints

- Video is user-produced and uploaded through the EXE; the program publishes it through official APIs after campaign activation.
- Imported video is authoritative and must never fall back to the three-second generated placeholder.
- Accepted video: MP4, H.264, 1080x1920, 20–45 seconds, `yuv420p` compatible.
- Accepted images: PNG; image/carousel dimensions follow existing platform validation.
- Archive import must reject traversal, absolute/drive paths, symlinks, duplicate logical slots, and decompression abuse.
- Activation is atomic, preserves the prior active batch, and survives restart.
- Media files remain outside SQLite; SQLite stores metadata and bindings only.
- Tokens and credentials never enter media archives, database rows, diagnostics, or logs.
- Public publishing remains disabled until explicit campaign activation.
- Daily ZIP remains a backup/audit path and must contain the same checksum-verified files used by publishers.

## Review Focus

- ZIP bombs and oversized entry counts must fail before extraction without altering active state.
- Windows path variants, Unicode names, and a single optional archive root directory must normalize consistently.
- An interrupted activation must leave the previous active batch usable.
- Reimporting identical bytes must be idempotent rather than duplicating managed files.
- Missing or invalid video must block approval/export/publishing with a clear `missing_media` or validation result.

---

### Task 1: Media Import Contracts and Safe Archive Inspection

**Files:**
- Create: `src/social_funnel/media/__init__.py`
- Create: `src/social_funnel/media/models.py`
- Create: `src/social_funnel/media/importer.py`
- Test: `tests/media/test_importer.py`

**Interfaces:**
- Produces: `inspect_media_zip(archive: Path, manifest: CampaignManifest, ffprobe: Callable | None = None) -> ImportReport`
- Produces: immutable `MediaSlot`, `ImportedFile`, `ImportIssue`, and `ImportReport` models.

- [ ] Write failing tests for optional root-prefix normalization, valid post/carousel/video slot parsing, traversal/absolute/drive/symlink rejection, duplicate logical slots, unknown files, maximum entry count, and maximum expanded-byte budget.
- [ ] Run `python -m pytest tests/media/test_importer.py -q` and confirm failures are caused by the missing media package.
- [ ] Implement central-directory inspection without extraction; normalize only `day-NN/<locale>/<filename>` after removing one shared root directory.
- [ ] Run the focused tests and confirm they pass.
- [ ] Commit with `feat: inspect monthly media archives safely`.

### Task 2: Image and Video Preflight

**Files:**
- Create: `src/social_funnel/media/probe.py`
- Modify: `src/social_funnel/media/importer.py`
- Test: `tests/media/test_probe.py`
- Modify: `tests/media/test_importer.py`

**Interfaces:**
- Consumes: parsed `MediaSlot` records from Task 1.
- Produces: `probe_image(path: Path) -> MediaMetadata` and `probe_video(path: Path, runner: Callable | None = None) -> MediaMetadata`.

- [ ] Write failing tests for real PNG inspection, disguised/invalid PNG, missing video stream, wrong codec, wrong 1080x1920 dimensions, duration below 20 seconds, duration above 45 seconds, sanitized ffprobe failure, and checksum calculation.
- [ ] Run the two media test files and observe the expected failures.
- [ ] Implement Pillow verification and a JSON `ffprobe` invocation; do not accept extension-only validation.
- [ ] Add staged extraction only after archive-level checks pass, with per-file and total byte enforcement during copying.
- [ ] Run focused tests and confirm all pass.
- [ ] Commit with `feat: validate imported campaign media`.

### Task 3: Durable Batches, Active Bindings, and Rollback

**Files:**
- Modify: `src/social_funnel/storage/schema.sql`
- Modify: `src/social_funnel/storage/repositories.py`
- Create: `src/social_funnel/media/service.py`
- Test: `tests/storage/test_media_imports.py`
- Test: `tests/media/test_service.py`

**Interfaces:**
- Produces: `MediaImportRepository.create_batch`, `add_file`, `activate`, `active_batch`, `active_files`, and `rollback`.
- Produces: `MediaImportService.preflight`, `activate`, `replace_slot`, and `rollback`.

- [ ] Write failing migration/repository tests proving old databases open safely, one active batch per campaign, transactional activation, rollback, and idempotent checksum/path reuse.
- [ ] Run focused tests and verify expected failures.
- [ ] Add `media_import_batch`, `media_import_file`, and `active_media_batch` tables using additive `CREATE TABLE IF NOT EXISTS` statements and indexes.
- [ ] Implement immutable managed storage under `workspace/media/imports/<batch-id>` and atomic staging-to-final movement.
- [ ] Write and run service tests for invalid import no-op, restart persistence, replacement as a new immutable file, and interrupted activation preserving the prior batch.
- [ ] Run all Task 3 tests and confirm they pass.
- [ ] Commit with `feat: persist monthly media batches`.

### Task 4: Media Resolution, Export, and Publisher Inputs

**Files:**
- Create: `src/social_funnel/media/resolver.py`
- Modify: `src/social_funnel/publishing/orchestrator.py`
- Modify: `src/social_funnel/exporting/manual_pack.py`
- Modify: `src/social_funnel/web/app.py`
- Test: `tests/media/test_resolver.py`
- Modify: `tests/publishing/test_orchestrator.py`
- Modify: `tests/exporting/test_manual_pack.py`

**Interfaces:**
- Produces: `MediaResolver.resolve(job: PublicationJob, content: LocalizedContent) -> MediaAsset | None`.
- Orchestrator and exporter receive one shared resolver instance.

- [ ] Write failing tests proving imported media wins, image/carousel fallback remains available, video has no generated fallback, Threads can be text-only, and publisher/export receive bytes matching the imported checksum.
- [ ] Run focused tests and verify the failures.
- [ ] Implement resolution and inject it into orchestrator/export code without changing publisher interfaces.
- [ ] Change non-video TikTok jobs to fail closed or be disabled by the documented policy; never synthesize video.
- [ ] Run focused tests, then `python -m pytest -q`.
- [ ] Commit with `feat: publish approved imported media`.

### Task 5: EXE Upload, Coverage, Activation, Replacement, and Rollback UI

**Files:**
- Modify: `src/social_funnel/web/routes.py`
- Modify: `src/social_funnel/web/templates/dashboard.html`
- Modify: `src/social_funnel/web/templates/content_detail.html`
- Create: `src/social_funnel/web/templates/media_import.html`
- Modify: `src/social_funnel/web/static/app.css`
- Modify: `tests/web/test_routes.py`

**Interfaces:**
- Consumes: `MediaImportService` and `MediaResolver` from Tasks 3–4.
- Produces routes for preflight upload, explicit activation, per-slot replacement, rollback, and 30×3 coverage display.

- [ ] Write failing route tests for CSRF, non-ZIP rejection, validation report rendering, no activation during preflight, explicit activation, coverage state, replacement, rollback, and safe error messages.
- [ ] Run `python -m pytest tests/web/test_routes.py -q` and verify failures.
- [ ] Implement multipart upload with bounded request/file size and temporary-file cleanup.
- [ ] Implement the Turkish UI copy: `Aylık medya yükle`, ready/missing/invalid statuses, batch history, preview links, replacement, and rollback.
- [ ] Run route tests and verify keyboard-accessible labels and status text.
- [ ] Run the full suite.
- [ ] Commit with `feat: add monthly media workspace`.

### Task 6: Campaign Activation Guard, Packaging, and Operator Documentation

**Files:**
- Modify: `src/social_funnel/storage/schema.sql`
- Modify: `src/social_funnel/scheduling/service.py`
- Modify: `src/social_funnel/web/routes.py`
- Modify: `src/social_funnel/web/templates/dashboard.html`
- Modify: `docs/operator-guide.md`
- Modify: `README.md`
- Modify: `packaging/social-funnel.spec`
- Modify: `tests/scheduling/test_scheduler.py`
- Modify: `tests/packaging/test_bundle_manifest.py`
- Modify: `tests/windows/test_launcher.py`

**Interfaces:**
- Produces persistent campaign activation state; scheduler processes jobs only when both unpaused and activated.

- [ ] Write failing tests proving import does not activate publishing, explicit activation persists, incomplete required video coverage blocks activation, pause still overrides activation, and packaged resources include the new templates/modules.
- [ ] Run focused tests and verify failures.
- [ ] Implement the activation guard and dashboard confirmation summary.
- [ ] Update operator documentation with ZIP layout, upload/preview/activation flow, rollback, and the distinction between EXE upload and official-API publishing.
- [ ] Run `python -m pytest -q` and require all tests to pass.
- [ ] Run `powershell -ExecutionPolicy Bypass -File packaging/build.ps1`.
- [ ] Run `powershell -ExecutionPolicy Bypass -File packaging/smoke-test.ps1`.
- [ ] Commit with `build: package monthly media publishing workflow`.

## Plan self-review

- Spec coverage: archive safety, validation, immutable storage, activation, rollback, resolution, publishing identity, UI, and packaging are each assigned.
- Scope boundary: OAuth/network implementation and production social posting remain separate; this plan only guarantees that the exact approved file reaches existing publisher inputs.
- Type consistency: importer yields `ImportReport`; service persists it; resolver yields existing `MediaAsset`; orchestrator/export consume the resolver.
- Review-focus coverage: each listed high-risk input has a named test in Tasks 1–4.
- No production implementation starts before its failing test.
