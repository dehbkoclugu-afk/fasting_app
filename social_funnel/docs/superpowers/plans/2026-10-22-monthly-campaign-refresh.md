# Monthly Campaign Refresh Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Import, preview, activate, and roll back immutable monthly 30-day campaign packages while keeping publishing off until the new month's videos and campaign are approved.

**Architecture:** A campaign package validator wraps the existing `CampaignManifest`. A repository/service persists immutable revisions and atomically switches the active campaign plus its jobs; a runtime registry lets routes, media, and publishing read the active manifest without restarting. FastAPI exposes the monthly workflow.

**Tech Stack:** Python 3.13, Pydantic, SQLite, FastAPI/Jinja, pytest, PyInstaller.

**Spec:** `docs/superpowers/specs/2026-10-22-monthly-campaign-refresh-design.md`

## Global Constraints

- Package month is `YYYY-MM`; manifest slug ends with that month.
- Exactly 30 ideas, 90 localized units, ten all-locale video days, and the 7/7/7/9 funnel sequence.
- Import never activates publishing; switching revisions deactivates it.
- Existing campaigns, jobs, media, and published history are never deleted.
- Identical packages are idempotent; invalid packages leave no database or managed-file changes.
- No LLM call, credential, video generation, or automatic public activation is added.

## Review Focus

- A malformed month, slug mismatch, mixed per-day formats, or wrong video-day count must fail before persistence.
- Duplicate package bytes and semantically identical packages must resolve to one revision.
- Activation failure must preserve the prior active revision and jobs.
- Restart must restore the active manifest without using the bundled launch catalog.
- A campaign switch must not reuse another campaign's media batch or publish before approval.

---

### Task 1: Package Contract and Validation

**Files:**
- Create: `src/social_funnel/campaign/package.py`
- Modify: `src/social_funnel/content/loader.py`
- Test: `tests/campaign/test_package.py`

**Interfaces:**
- Produces: `CampaignPackage`, `load_campaign_package(path: Path)`, and `validate_campaign_package(package)`.

- [ ] Write failing tests for valid package, malformed month, slug mismatch, mixed locale formats, wrong video-day count, missing localization, prohibited claims, and local-path leakage.
- [ ] Run `python -m pytest tests/campaign/test_package.py -q` and confirm the expected failures.
- [ ] Implement the immutable package model and aggregate validator using existing campaign and claim rules.
- [ ] Run focused tests and commit with `feat: validate monthly campaign packages`.

### Task 2: Immutable Revision Storage and Atomic Activation

**Files:**
- Modify: `src/social_funnel/storage/schema.sql`
- Modify: `src/social_funnel/storage/repositories.py`
- Create: `src/social_funnel/campaign/service.py`
- Test: `tests/storage/test_campaign_revisions.py`
- Test: `tests/campaign/test_service.py`

**Interfaces:**
- Produces: `CampaignRevisionRepository` import/list/active/activate/rollback methods.
- Produces: `CampaignRefreshService.preflight`, `activate`, and `rollback`.

- [ ] Write failing tests for additive migration, immutable/idempotent import, managed JSON copy, 360-job creation, activation persistence, rollback, preserved historical jobs, and interrupted activation.
- [ ] Run focused tests and verify failures.
- [ ] Add revision and active-binding tables; implement staged managed-file import.
- [ ] Implement one-transaction activation that imports the manifest/jobs, switches the binding, and sets `campaign_active=0`.
- [ ] Run focused tests and commit with `feat: persist monthly campaign revisions`.

### Task 3: Runtime Active Campaign

**Files:**
- Create: `src/social_funnel/campaign/registry.py`
- Modify: `src/social_funnel/web/app.py`
- Modify: `src/social_funnel/web/routes.py`
- Modify: `src/social_funnel/media/resolver.py`
- Test: `tests/campaign/test_registry.py`
- Modify: `tests/web/test_routes.py`

**Interfaces:**
- Produces: `CampaignRegistry.active_manifest()` and `active_month()`.
- Consumers resolve the manifest per operation instead of retaining the bundled launch manifest.

- [ ] Write failing tests proving restart restores the active revision and media lookups remain campaign-scoped.
- [ ] Run focused tests and verify failures.
- [ ] Implement the registry and inject it into web/media consumers with the bundled catalog as first-run seed only.
- [ ] Run focused tests and commit with `feat: select active monthly campaign at runtime`.

### Task 4: Monthly Campaign UI and Packaging

**Files:**
- Modify: `src/social_funnel/web/routes.py`
- Create: `src/social_funnel/web/templates/campaign_import.html`
- Modify: `src/social_funnel/web/templates/base.html`
- Modify: `src/social_funnel/web/templates/dashboard.html`
- Modify: `src/social_funnel/web/static/app.css`
- Modify: `docs/operator-guide.md`
- Modify: `README.md`
- Modify: `packaging/social-funnel.spec`
- Modify: `tests/web/test_routes.py`
- Modify: `tests/packaging/test_bundle_manifest.py`

**Interfaces:**
- Produces: `/campaigns`, `/campaigns/preflight`, `/campaigns/{revision_id}/activate`, and `/campaigns/rollback`.

- [ ] Write failing route tests for CSRF, invalid JSON, preview without activation, summary counts, explicit activation, rollback, safe errors, and publishing deactivation.
- [ ] Run route tests and verify failures.
- [ ] Implement bounded upload, temporary cleanup, Turkish revision history/preview UI, activation, and rollback.
- [ ] Update operator documentation and bundle assertions.
- [ ] Run `python -m pytest -q`, `packaging/build.ps1`, and `packaging/smoke-test.ps1`.
- [ ] Commit with `feat: add monthly campaign refresh workspace`.

## Plan self-review

- Spec coverage: package contract, immutable persistence, runtime switching, UI, rollback, safety, and packaging each have an owning task.
- Scope: authoring/generation stays outside the EXE; this slice imports reviewed monthly copy and renders its non-video media.
- Types: Task 1 package feeds Task 2 service; Task 2 active binding feeds Task 3 registry; Task 4 uses those public interfaces.
- Review risks are pinned to Tasks 1–4 tests.
