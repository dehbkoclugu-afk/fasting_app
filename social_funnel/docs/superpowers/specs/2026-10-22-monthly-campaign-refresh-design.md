# Monthly Campaign Refresh Design

## Outcome

FastTrack can load a new reviewed 30-day campaign for a target month without replacing the current month. The operator only supplies the 30 localized Reels videos; FastTrack renders the reviewed image and carousel slots, schedules the selected month, and preserves prior campaigns for rollback and audit.

## Chosen approach

Use immutable, versioned campaign JSON packages. This is safer than generating health copy inside the EXE and more maintainable than hard-coding a second catalog. The assistant can author a fresh package each month, while the local program owns validation, preview, activation, rendering, and publishing.

Rejected alternatives:

- Live LLM generation inside the EXE: requires an external credential, creates nondeterministic medical copy, and makes approval/audit harder.
- A fixed topic rotation: works offline but repeats quickly and cannot maintain campaign quality across seasons.

## Package contract

Each package is UTF-8 JSON and contains the existing `CampaignManifest` plus:

- `month`: `YYYY-MM`, interpreted in the campaign timezone.
- A unique slug ending in the target `YYYY-MM` month.
- Exactly 30 ordered ideas and 90 localized units.
- The existing 7/7/7/9 funnel-stage sequence.
- Exactly ten ideas where all three locales use `video`, therefore 30 required videos. A day's three locales must use the same preferred format.
- The remaining slots use `image` or `carousel`; carousels always render three slides.
- Localized hashtags, CTA, body, and hook are mandatory. `safety_note` remains structurally optional, prohibited-claim validation runs against every localized unit, and any supplied safety note is preserved exactly. Language identity is confirmed during human preview because the existing keyword heuristic rejects valid reviewed copy.

The package must not contain credentials, media paths, remote URLs, HTML, or executable content.

## Lifecycle

1. The operator opens **Aylık kampanya** and uploads a JSON package.
2. FastTrack validates structure, month, uniqueness, language coverage, format counts, and health-safety fields.
3. A valid package is stored as an immutable campaign revision and shown as a preview. Uploading identical content is idempotent.
4. Activation is explicit. In one database transaction it deactivates publishing, selects the campaign revision, creates its 360 publication jobs from the first day of the target month, and switches runtime content/media resolution to the new campaign slug without requiring an application restart.
5. The new month cannot publish until its 30 videos are imported and the campaign is explicitly enabled.
6. Prior campaign revisions, jobs, and media remain intact. Rollback selects the previous revision but never republishes completed jobs automatically.

## Storage and ownership

SQLite stores campaign revision metadata, the immutable manifest JSON, target month, checksum, and active/previous bindings. Existing campaign rows and publication jobs remain the source of truth for publishing. Uploaded JSON is copied into `workspace/campaigns/imports/<revision-id>/campaign.json` for audit.

## UI

Add an **Aylık kampanya** page with JSON upload, validation issues, a 30-day × 3-language summary, format totals, revision history, preview, activate, and rollback actions. The dashboard shows the selected month and keeps campaign publishing inactive after any revision switch.

## Error and safety behavior

Invalid packages do not change SQLite, jobs, media, or active state. A month already represented by different content is allowed as a new revision but must be activated explicitly. Activation is transactional: either the binding and all jobs switch together, or the prior campaign remains active. Existing published jobs are never deleted.

## Test boundary

Tests cover valid and malformed packages, duplicate months, idempotent uploads, unsafe text fields, immutable persistence, transactional activation, preserved historical jobs, explicit activation, media separation by campaign slug, rollback, restart persistence, UI CSRF, packaged resources, and the existing 110-test regression suite.

## Non-goals

- Generating Reels or synthetic video.
- Calling an LLM from the EXE.
- Automatically activating or publicly publishing a newly imported month.
- Rewriting already-published historical jobs.
