# Operator guide

## Daily review

1. Open the local dashboard and confirm the campaign is not unexpectedly paused.
2. Open the intended day and inspect each language separately.
3. Verify hook, body, call to action, hashtags, safety wording, visual crop, alt
   text, destination account, and scheduled local time.
4. Approve only the jobs that are ready. Disable a destination instead of
   improvising a replacement account.
5. Keep the campaign in approval mode until every destination has passed its own
   live check and platform review is complete.

Approval mode requires a person to approve each job. Automatic mode may advance
validated content only after the campaign is locked; it does not bypass account
capabilities, TikTok consent, platform review, or the one-destination live-send
confirmation.

## Opt-in live verification

Live verification is deliberately split into two actions:

1. Prepare a summary for one draft job and one exact account. Preparation checks
   the job state, account/platform/locale match, content revision, current
   capabilities, media, language, claims, accessibility, and aspect ratio.
2. Read the summary, compare the public identity on the platform, then confirm
   the separate send action immediately before it runs.

The preparation action never calls a publisher. It rejects lists or multiple
destinations, non-draft jobs, disabled/mismatched accounts, missing content, and
validation errors. Never turn a successful preparation into a batch send.

## Pause, failure, and recovery

- Use **Pause** before credential changes, incident investigation, or a campaign
  stop. Pause prevents new due work; an in-flight upload is allowed to finish.
- On restart, reconcile `uploading` and `processing` jobs with the platform before
  retrying. If the remote outcome cannot be proven, leave the job failed and
  inspect the public destination manually. Do not risk a duplicate post.
- Authentication/permission failures require reconnecting the exact account.
  Rate limits and transient server failures use bounded backoff.
- A partial upload or returned remote ID must be reconciled, not blindly retried.
- Resume only after the cause is understood and the dashboard destination counts
  are correct.

## Backups and restore

Create a backup before account mapping changes and at the end of each approved
campaign week. Backups contain the SQLite snapshot, sanitized settings, media,
and checksums; operating-system vault secrets are excluded.

Restore validates paths, checksums, schema version, JSON, and SQLite integrity in
a staging directory. A successful swap keeps the prior workspace beside the new
one with a timestamp. After restore, reconnect vault credentials as needed,
leave publishing paused, and inspect account identities before resuming.

## Manual fallback

If an API permission, app review, hosting, or platform outage blocks publishing:

1. Keep the affected account disabled or the campaign paused.
2. Use the day's **Export ZIP** action.
3. Upload each platform/language folder manually to the exact public identity.
4. Copy its caption and alt text, then verify the live result on-platform.
5. Record the remote post reference and outcome before any retry or resumption.

Manual fallback is the supported path while Meta review, TikTok audit, or a
public media host is unavailable; browser automation is not treated as a hidden
replacement for an approved publishing API.
