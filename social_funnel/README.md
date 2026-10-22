# FastTrack Social Funnel

FastTrack Social Funnel is a Windows-local review and publishing workspace for a
30-day campaign in Turkish, English, and Brazilian Portuguese. It expands 30
reviewed ideas into 90 localized content units and 360 destination jobs across
Instagram, Facebook, TikTok, and Threads.

## What is ready

- Local dashboard, day-by-day review, approval, disable, pause, resume, and ZIP export
- Immutable monthly campaign JSON import, validation, preview, activation, and rollback
- Monthly ZIP media import inside the EXE, content preflight, coverage view, immutable activation, and rollback
- Deterministic image/carousel/video rendering with preflight validation
- Meta and TikTok publishing adapters with retry and duplicate-send safeguards
- Secure TikTok Desktop OAuth with PKCE, exact-handle verification, and Windows Credential Manager storage
- Secure Facebook/Instagram pair discovery and Threads OAuth with exact public-identity checks
- Expiry-aware TikTok/Threads token rotation, exact-account publisher binding, and a
  live queue that checks due posts every 30 seconds while the EXE is open
- Windows onedir package, SHA-256 checksums, first-run workspace initialization,
  sanitized backups, and validated restore
- A single-destination live-check summary that never publishes by itself

New workspaces start in **approval mode**. No publisher is connected merely by
opening the app, and preparing a live check does not send content.

FastTrack automatically renders reviewed single-image and carousel content. Reels/TikTok videos are produced externally, uploaded once through **Aylık medya yükle**, validated as 1080×1920 H.264 MP4 files, and then passed unchanged to the scheduler and official platform publishers. The campaign remains inactive until all 30 localized video slots are present and the operator explicitly activates it.

Each month, import the reviewed campaign JSON through **Aylık kampanya** first. FastTrack validates all 30 days and 90 localized entries, stores an immutable revision, and switches months only after explicit activation. A campaign switch disables publishing; upload the new month's videos and complete review before enabling it again.

## Run the Windows package

1. Install FFmpeg and keep Windows Credential Manager enabled.
2. Keep the entire `FastTrack Social Funnel` distribution folder together.
3. Open `FastTrack Social Funnel.exe`.
4. The dashboard opens on `127.0.0.1`; data is stored under
   `%LOCALAPPDATA%\FastTrack Social Funnel`.

The app binds only to the local computer. If startup diagnostics fail, correct
the displayed FFmpeg, credential-vault, or workspace issue and reopen it.

## Build and verify

From the repository root in PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File social_funnel/packaging/build.ps1
powershell -ExecutionPolicy Bypass -File social_funnel/packaging/smoke-test.ps1
```

The build runs the offline test suite before packaging. Output is written to
`social_funnel/dist/FastTrack Social Funnel`; `checksums.sha256` covers every
distributed file.

See [account setup](docs/account-setup.md) before connecting a destination and
the [operator guide](docs/operator-guide.md) before approving or publishing.

