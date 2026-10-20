# Meta Publishing Adapters Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Connect the core workspace to Instagram, Facebook Pages, and Threads through official Meta APIs with secure tokens, verified outcomes, and isolated failures.

**Architecture:** A shared HTTP client provides retries, redaction, versioned Graph URLs, and container polling. Three adapters translate the shared publication contract into platform-specific create/upload/publish flows, while OAuth callbacks store tokens only in Windows Credential Manager.

**Tech Stack:** Python 3.13, HTTPX, FastAPI, keyring, pytest, respx

**Spec:** `docs/superpowers/specs/2026-10-20-multilingual-social-publishing-funnel-design.md`

## Global Constraints

- This plan depends on the completed core workspace plan.
- Use official Meta OAuth and publishing APIs; do not automate a browser login.
- Support three locales/accounts for each of Instagram, Facebook Pages, and Threads.
- Never persist tokens in SQLite, logs, exports, or source files.
- Require public media URLs only for endpoints that cannot accept file upload.
- No automated test or default command may publish live content.

## Review Focus

- A token refresh that succeeds concurrently in two workers must not corrupt the vault; Task 1 tests this.
- Container processing that remains pending until timeout must become retryable without creating a second container; Tasks 2 and 3 test this.
- A Graph response with HTTP 200 and an embedded error must be treated as failure; Task 1 tests this.
- Revoked page or account access must create a reconnect action, not retry forever; Tasks 2-4 test this.
- A redaction failure must never expose tokens or signed media URLs in audit logs; Task 1 tests this.

---

### Task 1: Credential vault and Meta Graph client

**Files:**
- Create: `social_funnel/src/social_funnel/auth/vault.py`
- Create: `social_funnel/src/social_funnel/publishing/meta/client.py`
- Create: `social_funnel/src/social_funnel/publishing/meta/errors.py`
- Test: `social_funnel/tests/auth/test_vault.py`
- Test: `social_funnel/tests/publishing/meta/test_client.py`

**Interfaces:**
- Consumes: account connection ids and audit logger from the core plan.
- Produces: `CredentialVault.get/set/delete`, `MetaGraphClient.request`, `MetaGraphClient.poll_container`, and normalized `MetaApiError(category, retryable, reconnect_required)`.

- [ ] **Step 1: Write failing vault and client tests**

Cover Windows-keyring references, concurrent refresh serialization, HTTP and embedded Graph errors, rate limits, redaction of access tokens and signed URLs, and polling timeout that preserves the original container id.

- [ ] **Step 2: Run focused tests and verify failure**

Run: `python -m pytest social_funnel/tests/auth social_funnel/tests/publishing/meta/test_client.py -v`
Expected: FAIL because the modules do not exist.

- [ ] **Step 3: Implement vault and client**

Use an injected keyring backend in tests, a per-account refresh lock, explicit Graph API version configuration, and structured redacted diagnostics.

- [ ] **Step 4: Run focused tests**

Run: `python -m pytest social_funnel/tests/auth social_funnel/tests/publishing/meta/test_client.py -v`
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add social_funnel/src/social_funnel/auth social_funnel/src/social_funnel/publishing/meta social_funnel/tests/auth social_funnel/tests/publishing/meta
git commit -m "feat: add secure Meta API foundation"
```

### Task 2: Instagram publisher

**Files:**
- Create: `social_funnel/src/social_funnel/publishing/meta/instagram.py`
- Test: `social_funnel/tests/publishing/meta/test_instagram.py`

**Interfaces:**
- Consumes: `MetaGraphClient`, `CredentialVault`, media host URL, and core `Publisher` protocol.
- Produces: `InstagramPublisher.publish`, `lookup_by_idempotency_key`, and `capabilities(account)`.

- [ ] **Step 1: Write failing Instagram tests**

Cover image, carousel, and Reel container creation; alt text where supported; processing poll; publish; remote id capture; idempotent reconciliation; invalid professional account; revoked permission; and pending-container timeout.

- [ ] **Step 2: Run the focused tests and verify failure**

Run: `python -m pytest social_funnel/tests/publishing/meta/test_instagram.py -v`
Expected: FAIL because the adapter does not exist.

- [ ] **Step 3: Implement Instagram publishing**

Map core formats to the supported container flow, preserve the first container id in attempt metadata, and return normalized reconnect or retry decisions.

- [ ] **Step 4: Run the focused tests**

Run: `python -m pytest social_funnel/tests/publishing/meta/test_instagram.py -v`
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add social_funnel/src/social_funnel/publishing/meta/instagram.py social_funnel/tests/publishing/meta/test_instagram.py
git commit -m "feat: publish FastTrack content to Instagram"
```

### Task 3: Facebook Page publisher

**Files:**
- Create: `social_funnel/src/social_funnel/publishing/meta/facebook.py`
- Test: `social_funnel/tests/publishing/meta/test_facebook.py`

**Interfaces:**
- Consumes: shared Meta client, Page access credential reference, and core `Publisher` protocol.
- Produces: `FacebookPagePublisher.publish`, `lookup_by_idempotency_key`, and `capabilities(account)`.

- [ ] **Step 1: Write failing Facebook tests**

Cover text/link, photo, video, scheduled publication where supported, remote id capture, lost Page role, permission revocation, invalid schedule time, and unknown timeout reconciliation.

- [ ] **Step 2: Run the focused tests and verify failure**

Run: `python -m pytest social_funnel/tests/publishing/meta/test_facebook.py -v`
Expected: FAIL because the adapter does not exist.

- [ ] **Step 3: Implement Facebook Page publishing**

Keep all Page-specific fields inside the adapter and fall back to application-side scheduling when server-side scheduling capability is absent.

- [ ] **Step 4: Run the focused tests**

Run: `python -m pytest social_funnel/tests/publishing/meta/test_facebook.py -v`
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add social_funnel/src/social_funnel/publishing/meta/facebook.py social_funnel/tests/publishing/meta/test_facebook.py
git commit -m "feat: publish FastTrack content to Facebook Pages"
```

### Task 4: Threads publisher

**Files:**
- Create: `social_funnel/src/social_funnel/publishing/meta/threads.py`
- Test: `social_funnel/tests/publishing/meta/test_threads.py`

**Interfaces:**
- Consumes: shared Meta client, Threads credential reference, and core `Publisher` protocol.
- Produces: `ThreadsPublisher.publish`, `lookup_by_idempotency_key`, and sequence-aware result metadata.

- [ ] **Step 1: Write failing Threads tests**

Cover text, image, video, link, poll capability rejection, two-to-four post sequence ordering, partial-sequence failure, publish-container polling, permission revocation, and duplicate reconciliation.

- [ ] **Step 2: Run the focused tests and verify failure**

Run: `python -m pytest social_funnel/tests/publishing/meta/test_threads.py -v`
Expected: FAIL because the adapter does not exist.

- [ ] **Step 3: Implement Threads publishing**

Publish sequences in order, store every remote id, stop on the first failed child, and allow a later retry to continue from the first unpublished child.

- [ ] **Step 4: Run the focused tests**

Run: `python -m pytest social_funnel/tests/publishing/meta/test_threads.py -v`
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add social_funnel/src/social_funnel/publishing/meta/threads.py social_funnel/tests/publishing/meta/test_threads.py
git commit -m "feat: publish FastTrack content to Threads"
```

### Task 5: Meta account connection UI and adapter registration

**Files:**
- Create: `social_funnel/src/social_funnel/web/meta_routes.py`
- Modify: `social_funnel/src/social_funnel/web/app.py`
- Modify: `social_funnel/src/social_funnel/web/templates/dashboard.html`
- Create: `social_funnel/tests/web/test_meta_routes.py`
- Create: `social_funnel/tests/publishing/meta/test_registry.py`

**Interfaces:**
- Consumes: vault, three Meta publishers, account repository, and web app factory.
- Produces: OAuth start/callback/disconnect routes and `register_meta_publishers(registry, settings)`.

- [ ] **Step 1: Write failing connection and registry tests**

Assert OAuth state validation, localhost callback handling, public identity storage without token storage, reconnect status, disconnect credential deletion, and correct adapter selection for nine Meta surfaces.

- [ ] **Step 2: Run the focused tests and verify failure**

Run: `python -m pytest social_funnel/tests/web/test_meta_routes.py social_funnel/tests/publishing/meta/test_registry.py -v`
Expected: FAIL because routes and registration do not exist.

- [ ] **Step 3: Implement routes and registration**

Require user interaction for OAuth, show requested permissions before redirect, and never auto-publish as part of account connection.

- [ ] **Step 4: Run Meta and core regression suites**

Run: `python -m pytest social_funnel/tests/publishing/meta social_funnel/tests/auth social_funnel/tests/web -v`
Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add social_funnel/src/social_funnel/web social_funnel/src/social_funnel/publishing/meta social_funnel/tests/web social_funnel/tests/publishing/meta
git commit -m "feat: connect Meta publishing accounts"
```

