# TikTok Publishing Adapter Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add safe TikTok photo and video publishing for three locale accounts, using review uploads before client audit and public direct posting only when approved.

**Architecture:** A TikTok HTTP client manages creator capability queries, OAuth tokens, chunked local video upload, URL-based photo publishing, and status polling. The adapter chooses review-upload or direct-post mode from verified account/client capabilities and records explicit user consent for each direct upload.

**Tech Stack:** Python 3.13, HTTPX, FastAPI, keyring, pytest, respx

**Spec:** `docs/superpowers/specs/2026-10-20-multilingual-social-publishing-funnel-design.md`

## Global Constraints

- This plan depends on the completed core workspace plan.
- Use TikTok Content Posting API only; do not automate TikTok's website.
- Unreviewed clients must not create public direct posts.
- Query creator capabilities immediately before direct posting.
- Require and record explicit consent before transmitting content to TikTok.
- Never reuse TikTok upload URLs or log their query parameters.
- No automated test may call TikTok production endpoints.

## Review Focus

- A creator whose allowed privacy options changed after scheduling must be revalidated before upload; Task 2 tests this.
- Chunk boundaries for a file exactly divisible by chunk size must not create an empty final chunk; Task 1 tests this.
- Revoked authorization during processing must terminate without retry; Tasks 1 and 2 test this.
- A photo post with an unverified source domain must be blocked before API submission; Task 2 tests this.
- Consent older than the current content revision must not authorize the revised upload; Task 2 tests this.

---

### Task 1: TikTok OAuth, API client, and media upload

**Files:**
- Create: `social_funnel/src/social_funnel/publishing/tiktok/client.py`
- Create: `social_funnel/src/social_funnel/publishing/tiktok/errors.py`
- Create: `social_funnel/src/social_funnel/publishing/tiktok/uploads.py`
- Test: `social_funnel/tests/publishing/tiktok/test_client.py`
- Test: `social_funnel/tests/publishing/tiktok/test_uploads.py`

**Interfaces:**
- Consumes: credential vault and audit logger from earlier plans.
- Produces: `TikTokClient.query_creator_info`, `init_video`, `init_photo`, `fetch_status`, `upload_video_file`, and normalized `TikTokApiError`.

- [ ] **Step 1: Write failing client and upload tests**

Cover creator info, OAuth refresh, six-request-per-minute handling, 5-64 MB chunk calculation with final chunk allowance, exact-divisibility boundaries, upload URL redaction, processing status, and `auth_removed` as terminal.

- [ ] **Step 2: Run focused tests and verify failure**

Run: `python -m pytest social_funnel/tests/publishing/tiktok/test_client.py social_funnel/tests/publishing/tiktok/test_uploads.py -v`
Expected: FAIL because TikTok modules do not exist.

- [ ] **Step 3: Implement the client and chunked uploader**

Treat returned upload URLs as single-use secrets, stream file chunks, and persist only the publish id plus redacted status metadata.

- [ ] **Step 4: Run focused tests**

Run: `python -m pytest social_funnel/tests/publishing/tiktok/test_client.py social_funnel/tests/publishing/tiktok/test_uploads.py -v`
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add social_funnel/src/social_funnel/publishing/tiktok social_funnel/tests/publishing/tiktok
git commit -m "feat: add TikTok content posting client"
```

### Task 2: TikTok review-upload and direct-post adapter

**Files:**
- Create: `social_funnel/src/social_funnel/publishing/tiktok/adapter.py`
- Test: `social_funnel/tests/publishing/tiktok/test_adapter.py`

**Interfaces:**
- Consumes: TikTok client, account capability flags, verified media-domain settings, and core `Publisher` protocol.
- Produces: `TikTokPublisher.publish`, `lookup_by_idempotency_key`, `capabilities(account)`, and `record_consent(job_id, content_revision, at)`.

- [ ] **Step 1: Write failing adapter tests**

Cover unaudited review upload, audited direct video post, photo URL verification, current creator privacy options, revised-content consent invalidation, disabled comments/duet/stitch mapping, AIGC label propagation, auth removal, and unknown outcome reconciliation.

- [ ] **Step 2: Run the focused tests and verify failure**

Run: `python -m pytest social_funnel/tests/publishing/tiktok/test_adapter.py -v`
Expected: FAIL because the adapter does not exist.

- [ ] **Step 3: Implement mode selection and consent enforcement**

Default to review upload. Enable direct post only when client audit, account authorization, creator capability, privacy selection, and current-revision consent all pass.

- [ ] **Step 4: Run the focused tests**

Run: `python -m pytest social_funnel/tests/publishing/tiktok/test_adapter.py -v`
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add social_funnel/src/social_funnel/publishing/tiktok/adapter.py social_funnel/tests/publishing/tiktok/test_adapter.py
git commit -m "feat: add safe TikTok publishing modes"
```

### Task 3: TikTok account connection and review UX

**Files:**
- Create: `social_funnel/src/social_funnel/web/tiktok_routes.py`
- Modify: `social_funnel/src/social_funnel/web/app.py`
- Modify: `social_funnel/src/social_funnel/web/templates/content_detail.html`
- Modify: `social_funnel/src/social_funnel/web/templates/dashboard.html`
- Test: `social_funnel/tests/web/test_tiktok_routes.py`

**Interfaces:**
- Consumes: TikTok publisher, vault, account repository, and local web app.
- Produces: OAuth connect/callback/disconnect routes, consent UI, privacy controls, and inbox-review status.

- [ ] **Step 1: Write failing route tests**

Assert OAuth state checks, token-vault references, public creator identity display, review-upload explanation, explicit direct-post consent, supported privacy values only, reconnect state, and disconnect cleanup.

- [ ] **Step 2: Run the focused tests and verify failure**

Run: `python -m pytest social_funnel/tests/web/test_tiktok_routes.py -v`
Expected: FAIL because TikTok routes do not exist.

- [ ] **Step 3: Implement connection and consent UX**

Show whether the app is unaudited, label review uploads as requiring completion in TikTok, and never treat an account connection as consent to publish a job.

- [ ] **Step 4: Run TikTok and web regression suites**

Run: `python -m pytest social_funnel/tests/publishing/tiktok social_funnel/tests/web -v`
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add social_funnel/src/social_funnel/web social_funnel/tests/web
git commit -m "feat: add TikTok connection and consent flow"
```

