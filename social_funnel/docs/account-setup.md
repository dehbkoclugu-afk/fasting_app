# Account setup

The campaign has twelve distinct surfaces. Never reuse an account ID across
languages or platforms.

| Locale | Instagram | Facebook Page | TikTok | Threads |
|---|---|---|---|---|
| Turkish (`tr`) | `tr-instagram` | `tr-facebook` | `tr-tiktok` | `tr-threads` |
| English (`en`) | `en-instagram` | `en-facebook` | `en-tiktok` | `en-threads` |
| Brazilian Portuguese (`pt-BR`) | `pt-BR-instagram` | `pt-BR-facebook` | `pt-BR-tiktok` | `pt-BR-threads` |

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
3. Create/select the matching Threads identity and verify its public handle.
4. Configure a Meta app with the exact Page/Instagram/Threads permissions used
   by the adapters, an explicit Graph API version, and production redirect URLs.
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
2. Configure Login Kit and the Content Posting API with the exact production
   redirect URI and scopes.
3. Start with creator-review upload. The creator finishes review in TikTok.
4. Complete TikTok's client audit before enabling public direct post.
5. For photo posting, verify the public HTTPS media domain first.
6. Store credentials in Windows Credential Manager and record only the vault
   reference and returned capabilities locally.

Every TikTok upload requires consent for the exact job ID and content revision.
Direct posting also refreshes creator privacy options immediately before the
send. An unaudited client must not be represented as capable of public direct
posting.

## Connection acceptance check

An account is ready only when all of the following agree: local account ID,
platform, locale, visible public identity, API-returned identity, enabled status,
vault reference, and current capabilities. Test one destination at a time. A
prepared check displays the exact content revision and still requires a separate
confirmation immediately before the live send.

