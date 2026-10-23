# Social Funnel Core Workspace Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a working Windows-local campaign workspace that expands the approved 30-day FastTrack campaign into 360 reviewable jobs, validates and renders them, schedules them, and exports manual publishing packs.

**Architecture:** A Python 3.13 FastAPI application runs on localhost and stores state in SQLite. Domain, storage, validation, rendering, scheduling, and web UI remain separate packages; platform publishers implement a shared protocol in later plans.

**Tech Stack:** Python 3.13, FastAPI, Uvicorn, Jinja2, Pydantic 2, Pillow, APScheduler, stdlib SQLite, boto3, pytest, HTTPX, FFmpeg 8

**Spec:** `docs/superpowers/specs/2026-10-20-multilingual-social-publishing-funnel-design.md`

## Global Constraints

- Keep all new code under `social_funnel/`; do not modify Flutter application behavior.
- Generate exactly 30 ideas, 90 localized units, and 360 platform jobs for TR, EN, and PT-BR across Instagram, Facebook, TikTok, and Threads.
- Store campaign data in SQLite and media under a configurable local workspace.
- Never store credentials or access tokens in SQLite or campaign files.
- Automatic jobs must pass the same validation gates as approval-mode jobs.
- Use Europe/Istanbul as the campaign timezone unless the user changes it.
- No test may publish to a real social account.

## Review Focus

- A rerun of campaign expansion must reuse stable idempotency keys and create no duplicate jobs; Task 3 tests this.
- Turkish dotted/dotless I and PT-BR diacritics must survive JSON, SQLite, HTML, and export; Tasks 2 and 7 test this.
- A missing screenshot or font must produce an actionable validation error rather than a crash; Tasks 4 and 5 test this.
- Daylight-saving or timezone conversion must never move a scheduled local post to a different campaign day; Task 7 tests this.
- Pausing the queue during an in-progress job must let that job finish while preventing the next job from starting; Task 7 tests this.

---

### Task 1: Python package and domain contracts

**Files:**
- Create: `social_funnel/pyproject.toml`
- Create: `social_funnel/src/social_funnel/__init__.py`
- Create: `social_funnel/src/social_funnel/domain/models.py`
- Create: `social_funnel/src/social_funnel/domain/publishing.py`
- Test: `social_funnel/tests/domain/test_models.py`

**Interfaces:**
- Consumes: Approved design values and enum states.
- Produces: `LocaleCode`, `Platform`, `AutomationMode`, `JobState`, `CampaignManifest`, `LocalizedContent`, `PublicationJob`, `MediaAsset`, `PublishResult`, `Publisher.publish(job, asset_path)`, and `Publisher.lookup_by_idempotency_key(key)`.

- [ ] **Step 1: Write failing model tests**

Assert that supported locales are `tr`, `en`, `pt-BR`; platforms are `instagram`, `facebook`, `tiktok`, `threads`; job transitions reject `draft -> published`; and `PublicationJob.idempotency_key` is required.

- [ ] **Step 2: Run the focused tests and verify failure**

Run: `python -m pytest social_funnel/tests/domain/test_models.py -v`
Expected: FAIL because `social_funnel.domain` does not exist.

- [ ] **Step 3: Implement the package and exact domain types**

Use frozen Pydantic models for campaign content, string enums for fixed values, an explicit `ALLOWED_TRANSITIONS` mapping, and a runtime-checkable `Publisher` protocol returning `PublishResult(remote_id, status, retryable, message)`. Configure `pyproject.toml` with base, `hosting`, `meta`, `tiktok`, `packaging`, and `dev` dependency groups so later plans extend one package rather than editing ad hoc environments.

- [ ] **Step 4: Run the focused tests**

Run: `python -m pytest social_funnel/tests/domain/test_models.py -v`
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add social_funnel/pyproject.toml social_funnel/src social_funnel/tests/domain
git commit -m "feat: add social funnel domain contracts"
```

### Task 2: Thirty-day multilingual campaign catalog

**Files:**
- Create: `social_funnel/content/fasttrack-30-day-launch.json`
- Create: `social_funnel/src/social_funnel/content/loader.py`
- Test: `social_funnel/tests/content/test_campaign_catalog.py`

**Interfaces:**
- Consumes: `CampaignManifest` and `LocalizedContent` from Task 1.
- Produces: `load_campaign(path: Path) -> CampaignManifest` and `validate_campaign_counts(manifest) -> None`.

- [ ] **Step 1: Write failing catalog tests**

Assert 30 unique days, the four approved funnel ranges, exactly three localized units per day, preserved strings `İlk haftanı sakin başlat` and `Comece sua rotina com calma`, nonempty hooks/bodies/CTAs, and no duplicate locale within a day.

- [ ] **Step 2: Run the focused tests and verify failure**

Run: `python -m pytest social_funnel/tests/content/test_campaign_catalog.py -v`
Expected: FAIL because the catalog and loader do not exist.

- [ ] **Step 3: Create the reviewed campaign catalog and loader**

Write all 30 themes and 90 localized units. Each unit includes `hook`, `body`, `cta`, `hashtags`, `safety_note`, `preferred_format`, and platform-specific copy overrides only where native behavior requires them.

- [ ] **Step 4: Run the focused tests**

Run: `python -m pytest social_funnel/tests/content/test_campaign_catalog.py -v`
Expected: PASS with `30 ideas / 90 localized units` in the assertion output.

- [ ] **Step 5: Commit**

```bash
git add social_funnel/content social_funnel/src/social_funnel/content social_funnel/tests/content
git commit -m "feat: add thirty day localized campaign"
```

### Task 3: SQLite schema, repositories, and deterministic expansion

**Files:**
- Create: `social_funnel/src/social_funnel/storage/schema.sql`
- Create: `social_funnel/src/social_funnel/storage/database.py`
- Create: `social_funnel/src/social_funnel/storage/repositories.py`
- Create: `social_funnel/src/social_funnel/campaign/expansion.py`
- Test: `social_funnel/tests/storage/test_repositories.py`
- Test: `social_funnel/tests/campaign/test_expansion.py`

**Interfaces:**
- Consumes: Task 1 models and Task 2 manifest.
- Produces: `Database.open(path)`, `CampaignRepository.import_manifest(manifest)`, `JobRepository`, and `expand_publication_jobs(manifest, accounts) -> tuple[PublicationJob, ...]`.

- [ ] **Step 1: Write failing repository and expansion tests**

Assert foreign keys are enabled, content round-trips UTF-8, credentials have no schema column, twelve configured accounts expand to 360 jobs, and importing the same manifest twice leaves 360 jobs with unchanged idempotency keys.

- [ ] **Step 2: Run the focused tests and verify failure**

Run: `python -m pytest social_funnel/tests/storage social_funnel/tests/campaign -v`
Expected: FAIL because storage and expansion modules do not exist.

- [ ] **Step 3: Implement schema and transaction-safe repositories**

Create the entities from the spec, unique indexes on natural identifiers and idempotency keys, explicit UTC timestamps, and repository methods `get_due_jobs(now, limit)`, `transition(job_id, expected_state, new_state)`, and `record_attempt(...)`.

- [ ] **Step 4: Implement deterministic job expansion**

Derive the idempotency key from campaign slug, day, locale, platform, account id, and content revision using SHA-256; never use database row ids.

- [ ] **Step 5: Run the focused tests**

Run: `python -m pytest social_funnel/tests/storage social_funnel/tests/campaign -v`
Expected: PASS.

- [ ] **Step 6: Commit**

```bash
git add social_funnel/src/social_funnel/storage social_funnel/src/social_funnel/campaign social_funnel/tests/storage social_funnel/tests/campaign
git commit -m "feat: persist and expand social campaigns"
```

### Task 4: Content and safety validation

**Files:**
- Create: `social_funnel/src/social_funnel/validation/rules.py`
- Create: `social_funnel/src/social_funnel/validation/service.py`
- Test: `social_funnel/tests/validation/test_validation.py`

**Interfaces:**
- Consumes: `LocalizedContent`, `PublicationJob`, and media metadata.
- Produces: `ValidationIssue(code, severity, message, field)` and `validate_job(job, content, asset) -> tuple[ValidationIssue, ...]`.

- [ ] **Step 1: Write failing validation tests**

Cover guaranteed weight loss, diagnosis/treatment language, prolonged-fasting encouragement, minor-directed language, wrong locale, empty CTA, missing required alt text, missing media, unsupported ratio, duplicate cooldown, local path leakage, absent screenshot, and absent font.

- [ ] **Step 2: Run the focused tests and verify failure**

Run: `python -m pytest social_funnel/tests/validation/test_validation.py -v`
Expected: FAIL because validation modules do not exist.

- [ ] **Step 3: Implement deterministic validation rules**

Keep rules data-driven by locale, return all issues in one pass, and classify blocking issues as `error` and review prompts as `warning`; do not call an external AI service.

- [ ] **Step 4: Run the focused tests**

Run: `python -m pytest social_funnel/tests/validation/test_validation.py -v`
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add social_funnel/src/social_funnel/validation social_funnel/tests/validation
git commit -m "feat: validate social content before publishing"
```

### Task 5: Reusable media renderer

**Files:**
- Create: `social_funnel/src/social_funnel/rendering/templates.py`
- Create: `social_funnel/src/social_funnel/rendering/images.py`
- Create: `social_funnel/src/social_funnel/rendering/video.py`
- Create: `social_funnel/assets/templates/README.md`
- Test: `social_funnel/tests/rendering/test_renderer.py`

**Interfaces:**
- Consumes: localized content, preferred format, FastTrack brand assets, and optional app screenshots.
- Produces: `render_asset(request: RenderRequest) -> MediaAsset` for 1080x1350, 1080x1080, and 1080x1920 output.

- [ ] **Step 1: Write failing renderer tests**

Assert exact dimensions, deterministic checksums, Turkish and PT-BR glyph rendering, safe text bounds, missing-resource errors, carousel page order, and an MP4 with H.264 video and AAC-or-no-audio accepted by FFprobe.

- [ ] **Step 2: Run the focused tests and verify failure**

Run: `python -m pytest social_funnel/tests/rendering/test_renderer.py -v`
Expected: FAIL because rendering modules do not exist.

- [ ] **Step 3: Implement image templates with Pillow**

Use FastTrack palette tokens from a small template registry, bundled Unicode fonts, high-contrast typography, and explicit safe areas for each aspect ratio.

- [ ] **Step 4: Implement short-video assembly with FFmpeg**

Generate 9:16 MP4 clips from rendered frames with subtle scale/fade transitions; report a blocking error when FFmpeg is unavailable.

- [ ] **Step 5: Run renderer tests and inspect representative outputs**

Run: `python -m pytest social_funnel/tests/rendering/test_renderer.py -v`
Expected: PASS and sample artifacts under pytest's temporary directory.

- [ ] **Step 6: Commit**

```bash
git add social_funnel/src/social_funnel/rendering social_funnel/assets social_funnel/tests/rendering
git commit -m "feat: render social campaign media"
```

### Task 6: Temporary public media hosting

**Files:**
- Create: `social_funnel/src/social_funnel/hosting/base.py`
- Create: `social_funnel/src/social_funnel/hosting/s3.py`
- Test: `social_funnel/tests/hosting/test_media_host.py`

**Interfaces:**
- Consumes: rendered `MediaAsset`, campaign retention settings, and credential-vault references.
- Produces: `PublicMediaHost.put(asset, expires_at) -> HostedMedia`, `get_public_url(hosted) -> str`, and `delete(hosted) -> None`.

- [ ] **Step 1: Write failing media-host tests**

Assert upload metadata contains no credential, generated object keys reveal no local path, URLs use HTTPS, signed query values are redacted from logs, expiry is later than the scheduled publication window, deletion is idempotent, and disabled hosting returns a blocking capability result instead of uploading.

- [ ] **Step 2: Run the focused tests and verify failure**

Run: `python -m pytest social_funnel/tests/hosting/test_media_host.py -v`
Expected: FAIL because hosting modules do not exist.

- [ ] **Step 3: Implement the protocol and S3-compatible provider**

Support S3, Cloudflare R2, or MinIO through endpoint configuration; store provider credentials only through vault references, generate opaque object keys, and provide explicit cleanup after the configured retention window.

- [ ] **Step 4: Run the focused tests**

Run: `python -m pytest social_funnel/tests/hosting/test_media_host.py -v`
Expected: PASS using a stubbed S3 client.

- [ ] **Step 5: Commit**

```bash
git add social_funnel/src/social_funnel/hosting social_funnel/tests/hosting
git commit -m "feat: host temporary social media assets"
```

### Task 7: Scheduler, approval mode, automatic mode, and global pause

**Files:**
- Create: `social_funnel/src/social_funnel/scheduling/service.py`
- Create: `social_funnel/src/social_funnel/publishing/orchestrator.py`
- Test: `social_funnel/tests/scheduling/test_scheduler.py`
- Test: `social_funnel/tests/publishing/test_orchestrator.py`

**Interfaces:**
- Consumes: repositories, validators, renderer, and `Publisher` implementations.
- Produces: `SchedulerService.tick(now)`, `PublishingOrchestrator.process(job_id)`, `pause()`, and `resume()`.

- [ ] **Step 1: Write failing orchestration tests**

Cover approval-mode blocking, automatic-mode validation, Europe/Istanbul day preservation across UTC conversion, per-platform failure isolation, bounded retry scheduling, no retry for auth errors, unknown-outcome reconciliation, duplicate prevention, and pause-during-current-job behavior.

- [ ] **Step 2: Run the focused tests and verify failure**

Run: `python -m pytest social_funnel/tests/scheduling social_funnel/tests/publishing -v`
Expected: FAIL because scheduling and orchestration modules do not exist.

- [ ] **Step 3: Implement scheduler and orchestrator**

Use a single-worker claim transaction, finish an already claimed job after pause, add exponential backoff with jitter capped at the configured maximum, and require `Publisher.lookup_by_idempotency_key` before retrying unknown outcomes.

- [ ] **Step 4: Run the focused tests**

Run: `python -m pytest social_funnel/tests/scheduling social_funnel/tests/publishing -v`
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add social_funnel/src/social_funnel/scheduling social_funnel/src/social_funnel/publishing social_funnel/tests/scheduling social_funnel/tests/publishing
git commit -m "feat: schedule and orchestrate publication jobs"
```

### Task 8: Local review UI and manual publishing packs

**Files:**
- Create: `social_funnel/src/social_funnel/web/app.py`
- Create: `social_funnel/src/social_funnel/web/routes.py`
- Create: `social_funnel/src/social_funnel/web/templates/base.html`
- Create: `social_funnel/src/social_funnel/web/templates/dashboard.html`
- Create: `social_funnel/src/social_funnel/web/templates/content_detail.html`
- Create: `social_funnel/src/social_funnel/web/static/app.css`
- Create: `social_funnel/src/social_funnel/exporting/manual_pack.py`
- Test: `social_funnel/tests/web/test_routes.py`
- Test: `social_funnel/tests/exporting/test_manual_pack.py`

**Interfaces:**
- Consumes: repository, renderer, validator, scheduler, and publication orchestrator interfaces.
- Produces: `create_app(settings) -> FastAPI` and `export_manual_pack(job_ids, destination) -> Path`.

- [ ] **Step 1: Write failing UI and export tests**

Assert the dashboard shows twelve destinations, state counts, connection health, and pause state; detail pages expose three locales and four platform variants; POST actions require a CSRF token; manual packs contain UTF-8 captions, hashtags, media, alt text, and a manifest without secrets or broken diacritics.

- [ ] **Step 2: Run the focused tests and verify failure**

Run: `python -m pytest social_funnel/tests/web social_funnel/tests/exporting -v`
Expected: FAIL because web and export modules do not exist.

- [ ] **Step 3: Implement the local-only FastAPI/Jinja interface**

Bind to `127.0.0.1`, use session-scoped CSRF tokens, support approve/reject/disable/publish-now/reschedule, and keep the browser UI usable at 1280x720 without horizontal scrolling.

- [ ] **Step 4: Implement ZIP manual packs**

Use one folder per locale/platform and a UTF-8 JSON manifest plus plain-text caption files; validate every selected job before writing the pack.

- [ ] **Step 5: Run UI and export tests**

Run: `python -m pytest social_funnel/tests/web social_funnel/tests/exporting -v`
Expected: PASS.

- [ ] **Step 6: Run the complete core suite**

Run: `python -m pytest social_funnel/tests -v`
Expected: PASS with no network access.

- [ ] **Step 7: Commit**

```bash
git add social_funnel/src/social_funnel/web social_funnel/src/social_funnel/exporting social_funnel/tests/web social_funnel/tests/exporting
git commit -m "feat: add social review workspace and exports"
```

