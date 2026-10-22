CREATE TABLE IF NOT EXISTS campaign (
  slug TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  timezone TEXT NOT NULL,
  manifest_json TEXT NOT NULL,
  created_at TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS account_connection (
  id TEXT PRIMARY KEY,
  platform TEXT NOT NULL,
  locale TEXT NOT NULL,
  public_identity TEXT,
  vault_reference TEXT,
  capabilities_json TEXT NOT NULL DEFAULT '{}',
  enabled INTEGER NOT NULL DEFAULT 1
);
CREATE TABLE IF NOT EXISTS publication_job (
  id TEXT PRIMARY KEY,
  campaign_slug TEXT NOT NULL REFERENCES campaign(slug),
  day INTEGER NOT NULL CHECK(day BETWEEN 1 AND 30),
  locale TEXT NOT NULL,
  platform TEXT NOT NULL,
  account_id TEXT NOT NULL REFERENCES account_connection(id),
  automation_mode TEXT NOT NULL,
  state TEXT NOT NULL,
  scheduled_at TEXT NOT NULL,
  idempotency_key TEXT NOT NULL UNIQUE,
  content_revision INTEGER NOT NULL,
  next_attempt_at TEXT,
  remote_id TEXT,
  last_error TEXT
);
CREATE INDEX IF NOT EXISTS idx_job_due ON publication_job(state, scheduled_at, next_attempt_at);
CREATE TABLE IF NOT EXISTS media_asset (
  checksum TEXT PRIMARY KEY,
  path TEXT NOT NULL,
  width INTEGER NOT NULL,
  height INTEGER NOT NULL,
  mime_type TEXT NOT NULL,
  alt_text TEXT NOT NULL,
  public_url TEXT
);
CREATE TABLE IF NOT EXISTS publication_attempt (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  job_id TEXT NOT NULL REFERENCES publication_job(id),
  attempted_at TEXT NOT NULL,
  outcome TEXT NOT NULL,
  remote_id TEXT,
  diagnostic TEXT NOT NULL,
  retry_count INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS application_state (
  key TEXT PRIMARY KEY,
  value TEXT NOT NULL
);
INSERT OR IGNORE INTO application_state(key, value) VALUES ('paused', '0');

CREATE TABLE IF NOT EXISTS media_import_batch (
  id TEXT PRIMARY KEY,
  campaign_slug TEXT NOT NULL REFERENCES campaign(slug),
  archive_checksum TEXT NOT NULL,
  created_at TEXT NOT NULL,
  UNIQUE(campaign_slug, archive_checksum)
);
CREATE TABLE IF NOT EXISTS media_import_file (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  batch_id TEXT NOT NULL REFERENCES media_import_batch(id) ON DELETE CASCADE,
  day INTEGER NOT NULL CHECK(day BETWEEN 1 AND 30),
  locale TEXT NOT NULL,
  kind TEXT NOT NULL,
  position INTEGER NOT NULL DEFAULT 0,
  managed_path TEXT NOT NULL,
  checksum TEXT NOT NULL,
  width INTEGER NOT NULL,
  height INTEGER NOT NULL,
  duration_ms INTEGER,
  mime_type TEXT NOT NULL,
  UNIQUE(batch_id, day, locale, kind, position)
);
CREATE TABLE IF NOT EXISTS active_media_batch (
  campaign_slug TEXT PRIMARY KEY REFERENCES campaign(slug),
  batch_id TEXT NOT NULL REFERENCES media_import_batch(id),
  previous_batch_id TEXT REFERENCES media_import_batch(id)
);
CREATE INDEX IF NOT EXISTS idx_media_file_slot ON media_import_file(batch_id, day, locale, kind, position);
