# Account setup

The campaign has twelve distinct surfaces. Never reuse an account ID across
languages or platforms.

| Locale | Instagram | Facebook Page | TikTok | Threads |
|---|---|---|---|---|
| Turkish (`tr`) | `tr-instagram` | `tr-facebook` | `tr-tiktok` | `tr-threads` |
| English (`en`) | `en-instagram` | `en-facebook` | `en-tiktok` | `en-threads` |
| Brazilian Portuguese (`pt-BR`) | `pt-BR-instagram` | `pt-BR-facebook` | `pt-BR-tiktok` | `pt-BR-threads` |

## Verified public identities (2026-10-20)

| Locale | Instagram | Facebook Page | TikTok | Threads |
|---|---|---|---|---|
| Turkish (`tr`) | `@fasttrack.fasting.tr` | `FastTrack Aralıklı Oruç` | `@fasttrack.fasting.tr` | `@fasttrack.fasting.tr` |
| English (`en`) | `@fasttrack.fasting.en` | `FastTrack Fasting` | `@fasttrack.fasting.en` | `@fasttrack.fasting.en` |
| Brazilian Portuguese (`pt-BR`) | `@fasttrack.fasting.br` | `FastTrack Jejum` | `@fasttrack.fasting.br` | `@fasttrack.fasting.br` |

These names were verified in the platform UIs. They are public identities, not
Graph API or TikTok API account IDs. Persist the provider-returned immutable IDs
only after OAuth connection and identity verification.

For each row, record the visible handle/Page name as `public_identity`, verify
that it matches the intended language, and keep the account disabled until its
connection test succeeds. Store only an operating-system vault reference in the
database. Passwords, access tokens, client secrets, recovery codes, and cookies
must never be placed in the repository, SQLite database, settings JSON, logs,
exports, or backups.

## Meta surfaces

1. Create or select one Facebook Page per locale.
2. Connect each Instagram professional account to the matching Page and confirm
   the professional-account status.
3. Configure a Meta app with Facebook Login for Business and the Page/Instagram
   permissions used by the adapters. Register the exact callback shown by the
   running EXE: `/oauth/meta/callback` on its loopback address and port.
4. Open **Hesaplar**, save the Meta App ID and secret, then connect each locale.
   One consent flow must return the expected Facebook Page and its linked
   Instagram professional account; both identities are enabled atomically.
5. Complete Meta App Review and, where required, business verification before
   enabling accounts for people outside app roles.
6. Store the resulting credential in Windows Credential Manager and save only
   its vault reference locally.
7. Read the destination capabilities, record them, and run a one-account live
   check before enabling scheduled publishing.

Instagram publishing requires a professional account and a public HTTPS media
URL. Threads media has the same public-hosting requirement; text-only Threads
posts do not. Facebook Page publishing requires a Page role and the approved
Page permissions. Meta development mode and missing review permissions can make
an apparently valid token work only for app-role accounts.

## TikTok surfaces

1. Create or select one TikTok account per locale and confirm the visible handle.
2. In TikTok Developer Center, configure a Desktop app with Login Kit and the
   Content Posting API. Allow the loopback callback
   `http://127.0.0.1:*/oauth/tiktok/callback` used by the local EXE.
3. Request `user.info.basic`, `user.info.profile`, and `video.upload`. The EXE
   intentionally starts in creator-review upload mode and does not claim direct
   public-post capability.
4. Open **Hesaplar** in FastTrack. Enter the Client key and Client secret once;
   both go directly to Windows Credential Manager and are never shown again.
5. Select **TikTok'a bağlan** for each language. Approve the official TikTok
   consent screen. FastTrack enables the row only when TikTok's returned handle
   exactly matches the expected public identity.
6. Complete TikTok's client audit before adding `video.publish` and direct public
   posting. For photo posting, verify the public HTTPS media domain first.

Every TikTok upload requires consent for the exact job ID and content revision.
Direct posting also refreshes creator privacy options immediately before the
send. An unaudited client must not be represented as capable of public direct
posting.

## Threads surfaces

1. Add the Threads API use case to a Meta app and register the exact local
   `/oauth/threads/callback` URI shown by the running EXE.
2. Open **Hesaplar** and store the Threads App ID and secret in Windows
   Credential Manager.
3. Connect each language account separately. FastTrack requests only
   `threads_basic` and `threads_content_publish`, exchanges the short-lived token
   for a long-lived token, and verifies the returned username exactly.

The current EXE implements connection flows for all twelve destinations: three
TikTok accounts, three Facebook/Instagram pairs, and three Threads accounts.
Provider review and real credentials are still required before connections can
be completed outside developer roles.

## Connection acceptance check

An account is ready only when all of the following agree: local account ID,
platform, locale, visible public identity, API-returned identity, enabled status,
vault reference, and current capabilities. Test one destination at a time. A
prepared check displays the exact content revision and still requires a separate
confirmation immediately before the live send.

