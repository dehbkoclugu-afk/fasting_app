import json
import sqlite3

from social_funnel.storage.database import Database
from social_funnel.storage.repositories import AccountConnectionRepository


def test_old_database_gains_account_identity_columns_without_data_loss(tmp_path):
    path = tmp_path / "old.db"
    connection = sqlite3.connect(path)
    connection.execute(
        """CREATE TABLE account_connection (
        id TEXT PRIMARY KEY, platform TEXT NOT NULL, locale TEXT NOT NULL,
        public_identity TEXT, vault_reference TEXT,
        capabilities_json TEXT NOT NULL DEFAULT '{}', enabled INTEGER NOT NULL DEFAULT 1
        )"""
    )
    connection.execute(
        "INSERT INTO account_connection(id,platform,locale) VALUES('tr-tiktok','tiktok','tr')"
    )
    connection.commit()
    connection.close()

    db = Database.open(path)
    columns = {row[1] for row in db.connection.execute("PRAGMA table_info(account_connection)")}
    row = db.connection.execute("SELECT * FROM account_connection WHERE id='tr-tiktok'").fetchone()

    assert {"provider_identity", "last_verified_at"} <= columns
    assert row["platform"] == "tiktok"
    db.close()


def test_connected_account_persists_only_safe_metadata_and_can_disconnect(tmp_path):
    db = Database.open(tmp_path / "campaign.db")
    db.connection.execute(
        "INSERT INTO account_connection(id,platform,locale) VALUES('tr-tiktok','tiktok','tr')"
    )
    db.connection.commit()
    accounts = AccountConnectionRepository(db)

    accounts.mark_connected(
        "tr-tiktok",
        provider_identity="open-123",
        public_identity="@fasttrack.fasting.tr",
        vault_reference="oauth:tr-tiktok",
        capabilities={"review_upload": True, "direct_public": False},
    )

    connected = accounts.get("tr-tiktok")
    assert connected["provider_identity"] == "open-123"
    assert connected["public_identity"] == "@fasttrack.fasting.tr"
    assert connected["vault_reference"] == "oauth:tr-tiktok"
    assert json.loads(connected["capabilities_json"]) == {
        "direct_public": False, "review_upload": True,
    }
    assert connected["enabled"] == 1
    assert connected["last_verified_at"]
    assert "access-token" not in str(dict(connected))

    accounts.disconnect("tr-tiktok")
    disconnected = accounts.get("tr-tiktok")
    assert disconnected["enabled"] == 0
    assert disconnected["provider_identity"] is None
    assert disconnected["vault_reference"] is None
    assert disconnected["public_identity"] == "@fasttrack.fasting.tr"
    db.close()
