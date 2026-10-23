# Multilingual Social Publishing Funnel Design

## Purpose

Build a Windows-first, local social publishing workspace for FastTrack. It will
create, review, schedule, and publish a 30-day organic campaign in Turkish,
English, and Brazilian Portuguese across Instagram, Facebook, TikTok, and
Threads.

The system supports both approval-based publishing and full automation. It is a
separate tool under `social_funnel/` and does not change the Flutter mobile app.

## Success criteria

- One 30-day campaign produces 30 core ideas, 90 localized content units, and
  360 platform-specific publishing jobs.
- Each platform/account can independently use approval or automatic mode.
- A failed platform does not block successful publication to other platforms.
- No duplicate post is created when a request times out or is retried.
- A nontechnical Windows user can operate the tool without a terminal.
- Credentials are not stored in source control or plaintext configuration.
- Health and weight-loss claims are checked before approval or publication.

## Accounts and surfaces

The launch configuration contains twelve publishing surfaces:

- three Instagram professional accounts: Turkish, English, and Portuguese;
- three Facebook Pages: Turkish, English, and Portuguese;
- three TikTok creator/business accounts: Turkish, English, and Portuguese;
- three Threads accounts paired with the corresponding Instagram accounts.

Account creation, identity verification, page ownership, and developer-app
approval remain user-controlled setup steps. The tool connects accounts only
through their official authorization flows and never collects account
passwords.

## Content strategy

FastTrack should occupy a calmer position than competitors that emphasize rapid
weight loss, aggressive transformation, or complex coaching. Its recurring
promise is a sustainable fasting rhythm with clear tracking, useful education,
and local-first privacy.

Competitor research is recorded as inspiration metadata rather than copied
creative:

- Zero Longevity: fasting plus protein, AI meal scanning, hydration, and
  science-led positioning;
- Fastic: beginner education, daily motivation, and lifestyle framing;
- BodyFast: personalized plans, community, testimonials, and result-oriented
  social proof.

FastTrack's differentiators are calm design, low-pressure habit building,
on-device core records, clear fasting stages, hydration and weight tracking,
and native language support.

### Thirty-day funnel

| Days | Funnel stage | Goal | Themes |
| --- | --- | --- | --- |
| 1-7 | Awareness | Make fasting approachable | What intermittent fasting is, 12:12 vs 16:8, eating windows, hydration, beginner mistakes, realistic expectations, weekly reset |
| 8-14 | Activation | Show the first useful session | Starting a timer, choosing a plan, metabolic-stage education, reminders, water logging, weight logging, first-week review |
| 15-21 | Habit | Build consistency without pressure | Streaks without guilt, hunger cues, routine anchors, social situations, sleep and hydration, progress charts, weekly reflection |
| 22-30 | Trust and conversion | Turn interest into an install or trial | Privacy, feature demonstrations, use cases, myths, user-story templates, premium comparison, FAQs, safety guidance, 30-day recap, store CTA |

Every day has one core idea. The idea is localized for each market and then
adapted to each platform.

### Localization

- Turkish content is practical and direct, using familiar meal-time examples.
- English content uses accessible science and a sustainable-habit tone.
- Brazilian Portuguese content is warmer and more conversational, emphasizing
  energy, routine, and community.

Localization changes examples, hooks, CTA phrasing, caption rhythm, and
hashtags. It is not a literal translation pass. Medical meaning and safety
language must remain equivalent across languages.

### Platform adaptation

- Instagram: 9:16 Reels, 4:5 images, and carousels with save/share CTAs.
- Facebook: explanatory copy, image or video, and a clear store or education
  link where appropriate.
- TikTok: vertical video or photo mode with a strong opening in the first two
  seconds and a native, low-polish presentation.
- Threads: concise observations, questions, polls where supported, and short
  two-to-four-post threads. It does not receive duplicated Instagram captions.

The base monthly mix is twelve short videos, ten carousels/photo series, and
eight single-image concepts. Platform adapters may turn a carousel into TikTok
photo mode or a short Threads sequence while preserving the day's purpose.

## Architecture

The tool is a local web application packaged for Windows and launched from a
desktop shortcut. The local UI talks only to a local application service; that
service owns content generation, rendering, scheduling, and platform API calls.

Focused components:

1. **Campaign catalog** stores the 30 core ideas and their funnel metadata.
2. **Localization layer** stores reviewed TR, EN, and PT-BR variants.
3. **Platform adapters** transform a localized unit into Instagram, Facebook,
   TikTok, or Threads copy and media requirements.
4. **Media renderer** produces 4:5, 1:1, and 9:16 assets from reusable FastTrack
   templates, app screenshots, and approved brand assets.
5. **Review workspace** previews all variants and supports per-job editing,
   approval, rejection, disabling, and immediate publishing.
6. **Scheduler** selects due jobs and hands each one to the appropriate adapter.
7. **Publisher adapters** implement official Meta, TikTok, and Threads API
   flows without exposing platform details to the scheduler.
8. **Credential vault** stores tokens through Windows Credential Manager.
9. **Audit log** records every state change, attempt, response category, and
   remote post identifier.

SQLite is the local source of truth. Generated media remains in the local
workspace. A configurable public media host is used only when a platform must
fetch media from a URL; local-file upload is preferred when the platform
supports it.

## Data model

The minimum persistent entities are:

- `campaign`: name, dates, timezone, and status;
- `content_idea`: day, funnel stage, purpose, safety notes, and source tags;
- `localized_content`: idea, locale, hook, body, CTA, and hashtags;
- `publication_job`: localized content, platform, account, format, scheduled
  time, automation mode, state, and idempotency key;
- `media_asset`: source template, local path, dimensions, checksum, and optional
  temporary public URL;
- `account_connection`: platform, locale, public account identity, capability
  flags, and credential-vault reference;
- `publication_attempt`: job, timestamp, outcome category, remote identifier,
  retry count, and redacted diagnostic message.

Credentials and raw access tokens are never stored in SQLite.

## Publication states and flows

A job moves through:

`draft -> needs_review -> approved -> scheduled -> uploading -> processing -> published`

Terminal alternatives are `rejected`, `disabled`, and `failed`. A retryable
failure returns to `scheduled` with a future attempt time. A job cannot enter
`published` without a platform post identifier or a verified final status.

### Approval mode

1. Generate copy and media preview.
2. Run language, safety, dimension, and duplication checks.
3. Wait for explicit approval.
4. Publish immediately or at the approved scheduled time.

### Automatic mode

1. Generate from a locked, previously approved campaign/template.
2. Run the same validation gates as approval mode.
3. Stop on any blocking validation result; never publish by guessing.
4. Publish at the scheduled time and verify the remote result.

Automation is configurable per account and platform. TikTok uses upload-for-
review while the developer client is unaudited; direct public posting is enabled
only after TikTok approval. Instagram, Facebook, and Threads use their official
publishing APIs after the required account and app permissions are active.

## Windows interface

The home screen shows:

- today's jobs and their twelve account destinations;
- approval count, scheduled count, published count, and actionable failures;
- a calendar view of the 30-day funnel;
- account connection health and token-expiry warnings;
- global pause/resume controls.

Opening a content card shows the three localized units and their four platform
variants. The user can preview media, edit copy, toggle destinations, approve a
single job, approve all valid variants, publish now, or reschedule.

Global pause prevents new publication attempts without deleting the queue.

## Safety and policy controls

Pre-publication validation blocks:

- diagnosis, treatment, prevention, guaranteed weight loss, or guaranteed
  metabolic outcomes;
- unsafe encouragement of prolonged fasting or content directed at minors;
- missing safety language where the topic requires it;
- wrong-language copy, empty CTA, missing alt text where supported, invalid
  aspect ratio, excessive text overflow, or unavailable media;
- exact or near-duplicate publication to the same account within the configured
  cooldown window;
- accidental inclusion of credentials, local paths, or internal notes.

TikTok content follows its current content-sharing requirements, including user
consent for uploads and restrictions applied to unaudited clients. AI-generated
media is labeled when a platform requires it.

## Error handling

- Network errors, rate limits, and temporary platform errors use bounded
  exponential backoff with jitter.
- Authentication and permission errors never retry automatically; they create a
  reconnect action.
- Media validation errors return the job to review with a specific correction.
- Idempotency keys and remote-status checks prevent duplicate posts after an
  unknown timeout outcome.
- One adapter failure is isolated from all other platform/account jobs.
- Logs redact tokens, authorization headers, private upload URLs, and personal
  data.
- Temporary hosted media is removed after the retention window when removal is
  supported; local source media remains until the campaign is archived.

## Testing

Automated tests use fake clocks, fake credential storage, temporary SQLite
databases, and stub platform clients. They never post to a real account.

Required coverage:

- 30 ideas expand to 90 localized units and 360 publication jobs;
- each account's automatic/approval setting is respected;
- disabling one destination does not alter the other eleven;
- scheduled jobs honor the Europe/Istanbul campaign timezone;
- retries are bounded and do not duplicate publication;
- unknown timeout outcomes are reconciled before retrying;
- expired authorization creates a reconnect action;
- validation blocks unsafe claims, wrong language, missing media, and overflow;
- generated images and videos satisfy each adapter's declared dimensions and
  file constraints;
- global pause prevents new attempts and resume continues the queue;
- audit records exclude secrets;
- TikTok unaudited mode produces reviewable/private uploads rather than public
  direct posts.

After automated tests pass, live verification uses one explicitly selected
draft per platform. No live test proceeds without the user choosing the exact
account, content, and destination.

## Delivery boundaries

This project delivers the local Windows application, campaign data, localized
copy, reusable creative templates, publishing adapters, setup guidance, and
tests.

It does not create social accounts, impersonate the user during verification,
buy advertising, manage comments or direct messages, scrape private analytics,
or guarantee platform approval. Paid-ad campaign creation is outside this first
release; competitor ad research informs organic creative only.

## Source notes

- Zero Longevity product positioning: <https://zerolongevity.com/>
- BodyFast product and community positioning: <https://www.bodyfast.app/en/>
- TikTok Content Posting API: <https://developers.tiktok.com/docs/en/content-posting-api-get-started>
- TikTok content-sharing guidelines: <https://developers.tiktok.com/docs/en/content-sharing-guidelines>
- Meta Instagram API collection: <https://www.postman.com/meta/instagram/documentation/6yqw8pt/instagram-api>
- Meta Threads API collection: <https://www.postman.com/meta/threads/documentation/dht3nzz/threads-api>

