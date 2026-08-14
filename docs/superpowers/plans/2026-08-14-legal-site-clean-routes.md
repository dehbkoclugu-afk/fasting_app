# Legal Site Clean Routes Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make the public Google Play legal URLs return the existing legal pages without exposing the `legal_site/` directory.

**Architecture:** Add a single Vercel configuration file at the repository root. Explicit rewrites map clean public routes and the shared stylesheet to the existing static files under `legal_site/`; no Flutter or legal-copy files change.

**Tech Stack:** Vercel static routing, JSON, curl

## Global Constraints

- Preserve every existing file under `legal_site/`.
- Keep the existing nested `/legal_site/.../` URLs working.
- Add no dependency or application-code change.
- The clean privacy and deletion URLs must return HTTP 200 before merge.

---

### Task 1: Add and verify clean legal routes

**Files:**
- Create: `vercel.json`
- Test: live Vercel deployment HTTP responses

**Interfaces:**
- Consumes: existing `legal_site/index.html`, `legal_site/privacy/index.html`, `legal_site/terms/index.html`, `legal_site/delete-account/index.html`, `legal_site/support/index.html`, and `legal_site/styles.css`
- Produces: public routes `/`, `/privacy/`, `/terms/`, `/delete-account/`, `/support/`, and `/styles.css`

- [ ] **Step 1: Record the current failing and passing routes**

Run:

```bash
test "$(curl -sS -o /dev/null -w '%{http_code}' https://fasting-app-mauve.vercel.app/privacy/)" = "404"
test "$(curl -sS -o /dev/null -w '%{http_code}' https://fasting-app-mauve.vercel.app/legal_site/privacy/)" = "200"
```

Expected: both commands exit successfully, proving the clean route is broken while the source page exists.

- [ ] **Step 2: Create the minimal root Vercel configuration**

Create `vercel.json` with:

```json
{
  "cleanUrls": true,
  "trailingSlash": true,
  "rewrites": [
    { "source": "/", "destination": "/legal_site/index.html" },
    { "source": "/privacy/", "destination": "/legal_site/privacy/index.html" },
    { "source": "/terms/", "destination": "/legal_site/terms/index.html" },
    { "source": "/delete-account/", "destination": "/legal_site/delete-account/index.html" },
    { "source": "/support/", "destination": "/legal_site/support/index.html" },
    { "source": "/styles.css", "destination": "/legal_site/styles.css" }
  ]
}
```

- [ ] **Step 3: Validate the configuration before deployment**

Run:

```bash
python -m json.tool vercel.json >/dev/null
```

Expected: exit code 0.

- [ ] **Step 4: Commit and open a pull request**

```bash
git add vercel.json docs/superpowers/specs/2026-08-14-legal-site-routes-design.md docs/superpowers/plans/2026-08-14-legal-site-clean-routes.md
git commit -m "fix: publish clean legal site routes"
git push -u origin agent/fix-legal-site-routes
```

Open a pull request from `agent/fix-legal-site-routes` into `main`.

- [ ] **Step 5: Verify the preview deployment**

Copy the exact **Preview** URL from the Vercel bot comment on the pull request, then run:

```bash
LEGAL_PREVIEW_URL='https://the-exact-preview-host-from-the-pr.vercel.app'
for path in privacy/ terms/ delete-account/ support/ styles.css; do
  test "$(curl -sS -o /dev/null -w '%{http_code}' "${LEGAL_PREVIEW_URL}/$path")" = "200"
done
curl -fsS ${LEGAL_PREVIEW_URL}/privacy/ | grep -q "Fasting Tracker"
curl -fsS ${LEGAL_PREVIEW_URL}/privacy/ | grep -q "CEY Studio"
```

Expected: every route returns 200 and the privacy copy contains both required identities.

- [ ] **Step 6: Merge and verify production**

Merge the pull request only after the preview checks pass. Then run:

```bash
for path in privacy/ terms/ delete-account/ support/ styles.css; do
  test "$(curl -sS -o /dev/null -w '%{http_code}' "https://fasting-app-mauve.vercel.app/$path")" = "200"
done
curl -fsS https://fasting-app-mauve.vercel.app/privacy/ | grep -q "Fasting Tracker"
curl -fsS https://fasting-app-mauve.vercel.app/privacy/ | grep -q "CEY Studio"
```

Expected: every production route returns 200 and the required privacy identity is present.
