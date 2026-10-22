# Legal site clean routes design

Date: 2026-08-14

## Context

The legal pages are stored under `legal_site/`, while Vercel currently deploys the repository root. The published pages therefore work at `/legal_site/privacy/` and `/legal_site/delete-account/`, but the intended Google Play URLs `/privacy/` and `/delete-account/` return 404.

## Options considered

1. **Root Vercel rewrites (selected):** add one root `vercel.json` that maps the clean public routes and shared stylesheet to the existing `legal_site/` files. This preserves the current files and URLs while making the store-facing routes stable.
2. **Use the nested URLs directly:** no code change, but exposes an implementation directory in permanent store URLs and leaves internal navigation/CSS fragile.
3. **Move the legal site to the repository root:** clean output, but touches many files and risks disturbing the Flutter repository layout.

## Design

Add a root `vercel.json` with explicit rewrites for:

- `/` → `/legal_site/index.html`
- `/privacy/` and `/privacy` → `/legal_site/privacy/index.html`
- `/terms/` and `/terms` → `/legal_site/terms/index.html`
- `/delete-account/` and `/delete-account` → `/legal_site/delete-account/index.html`
- `/support/` and `/support` → `/legal_site/support/index.html`
- `/styles.css` → `/legal_site/styles.css`

Existing nested URLs remain available. No application code, legal copy, or build configuration changes.

## Verification

After deployment:

- each clean route must return HTTP 200;
- the privacy page must contain “Fasting Tracker” and “CEY Studio”;
- the deletion page must load successfully;
- `/styles.css` must return HTTP 200;
- existing `/legal_site/.../` routes must continue to work.

## Scope review

The change is intentionally limited to one routing configuration file. There are no placeholders, runtime dependencies, or changes to legal content.
