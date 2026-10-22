# Operator guide

## Account connections

1. Open **Hesaplar**. The twelve known public destinations are prefilled but
   start disabled.
2. Save the TikTok Desktop app's Client key and Client secret once. These values
   are stored only in Windows Credential Manager.
3. Connect Turkish, English, and Brazilian Portuguese TikTok and Threads
   accounts one at a time. The official callbacks verify immutable identities
   and exact public handles.
4. Save the Meta App credentials, then connect each locale's Facebook Page and
   linked Instagram professional account as one verified pair.
5. Configure the dedicated S3-compatible bucket under **Medya barındırma**. Its
   public HTTPS URL is required for Instagram and media-bearing Threads posts.
6. Disconnecting any account, Meta pair, or media host immediately disables campaign
   publishing. Provider app review and required permissions must still be
   completed before non-developer accounts can authorize.

Never paste a social-account password into FastTrack. FastTrack accepts only
official provider authorization and developer-app credentials.

## Monthly campaign refresh

1. Obtain the reviewed monthly campaign JSON package prepared for the target month. Content generation and health-copy review happen outside the EXE; the EXE never invents or silently rewrites campaign copy.
2. Open **Aylık kampanya**, select the JSON file, and run the preflight check.
3. Confirm the month, campaign name, 30-day/90-language totals, and single-image, carousel, and video distribution shown in the preview.
4. Use **Bu sürümü etkinleştir** only for the reviewed revision. Activation creates the month's 360 destination jobs and automatically disables publishing.
5. Open **Aylık medya yükle** and upload that campaign's 30 localized Reels files. FastTrack generates the reviewed single-image and carousel artwork itself.
6. Review media and jobs, then explicitly enable the campaign. A JSON upload or revision switch never publishes by itself.
7. If the wrong revision was selected, use **Önceki kampanyaya dön**. Historical jobs and media remain intact, and publishing stays disabled until reviewed again.

Uploading identical JSON is idempotent. Invalid, unsafe, or incomplete packages do not alter the active campaign. Campaign and media revisions are scoped by campaign slug, so a prior month's uploads cannot leak into a newly activated month.

## Monthly media import

1. Produce the 30 localized Reels files outside FastTrack: ten designated video days in Turkish, English, and Brazilian Portuguese.
2. Place them in a ZIP using `day-01/tr/video.mp4`, `day-01/en/video.mp4`, and `day-01/pt-BR/video.mp4` style paths. One shared outer folder is allowed.
3. Open **Medya → Aylık medya yükle** in the EXE and choose the ZIP.
4. Review the preflight result and the 30-day × 3-language coverage grid. The importer rejects unsafe paths, unknown slots, duplicate slots, invalid images, and videos outside the approved H.264 1080×1920 20–45 second contract.
5. Activating a media batch only chooses which files the workspace uses; it does not start publishing.
6. Review the campaign, then use **İnceledim ve kampanyayı etkinleştir**. This action remains blocked until all 30 required videos, all 12 official account connections, and public media hosting exist; every account needs a verified public identity and a Windows Credential Manager reference. Activation schedules all 270 Instagram, Facebook, and Threads jobs in one batch.
7. Once activated, the scheduler supplies the exact checksum-verified uploaded files to the official platform adapters. The operator does not re-upload them separately on each platform.
8. **Önceki pakete dön** restores the previously active media batch. Pause or deactivate the campaign before rollback during an incident.

Use **Tek dosya değiştir** for a late correction. It clones the active package, replaces only the selected slot, and leaves the active package untouched until the new preview is explicitly activated. Activating or rolling back a media package automatically deactivates publishing, so the changed package must be reviewed before the campaign is enabled again.

Single-image and three-slide carousel assets are rendered automatically from the reviewed localized campaign catalog. Imported replacements take priority. Video slots never fall back to generated three-second placeholder clips.

## Daily review

1. Open the local dashboard and confirm the campaign is not unexpectedly paused.
2. Open the intended day and inspect each language separately.
3. Verify hook, body, call to action, hashtags, safety wording, visual crop, alt
   text, destination account, and scheduled local time.
4. Approve only the jobs that are ready. Disable a destination instead of
   improvising a replacement account.
   TikTok requires the separate **TikTok'a yüklenmesini açıkça onaylıyorum**
   checkbox for that exact content revision. Creator-review uploads remain in
   processing while the queue checks TikTok's status automatically. The day
   screen shows the remote operation ID, Creator inbox guidance, and a safe
   platform failure reason when intervention is required.
5. Keep the campaign in approval mode until every destination has passed its own
   live check and platform review is complete.

Campaign activation is the batch approval for Instagram, Facebook, and Threads.
The 30 TikTok video jobs still require their exact-revision checkbox; 60
non-video TikTok audit rows remain disabled. No mode bypasses account
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

Manual ZIP export is the backup/audit path while Meta review, TikTok audit, or a
public media host is unavailable. Normal operation publishes the activated media
through official APIs; browser automation is not treated as a hidden replacement.
