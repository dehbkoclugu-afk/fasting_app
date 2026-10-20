from datetime import date
from pathlib import Path

import pytest

from social_funnel.domain.models import JobState, MediaAsset
from social_funnel.setup.service import initialize_workspace
from social_funnel.storage.database import Database
from social_funnel.storage.repositories import CampaignRepository, JobRepository
from social_funnel.verification.live_check import LiveCheckError, prepare_live_check


def _prepared(tmp_path: Path):
    workspace = tmp_path / "live-check"
    initialize_workspace(workspace, start_date=date(2026, 10, 20))
    database = Database.open(workspace / "campaign.db")
    row = database.connection.execute(
        "SELECT id, account_id FROM publication_job "
        "WHERE platform='instagram' AND locale='en' ORDER BY day LIMIT 1"
    ).fetchone()
    media = tmp_path / "approved.png"
    media.write_bytes(b"reviewed-media")
    asset = MediaAsset(
        path=media,
        width=1080,
        height=1350,
        checksum="reviewed-sha",
        mime_type="image/png",
        alt_text="FastTrack day one",
    )
    return database, row["id"], row["account_id"], asset


def test_summary_pins_one_exact_destination_and_requires_last_moment_confirmation(tmp_path: Path) -> None:
    database, job_id, account_id, asset = _prepared(tmp_path)
    try:
        summary = prepare_live_check(
            job_id,
            account_id,
            jobs=JobRepository(database),
            campaigns=CampaignRepository(database),
            asset=asset,
        )
    finally:
        database.close()

    assert summary.job_id == job_id
    assert summary.account_id == account_id
    assert summary.platform == "instagram"
    assert summary.locale == "en"
    assert summary.content_revision == 1
    assert summary.destination_count == 1
    assert summary.requires_confirmation is True
    assert summary.confirmation_timing == "immediately_before_send"
    assert summary.send_performed is False


def test_rejects_non_draft_invalid_or_multiple_destinations(tmp_path: Path) -> None:
    database, job_id, account_id, asset = _prepared(tmp_path)
    jobs = JobRepository(database)
    campaigns = CampaignRepository(database)
    try:
        with pytest.raises(LiveCheckError, match="one destination"):
            prepare_live_check(
                job_id,
                (account_id, "another-account"),
                jobs=jobs,
                campaigns=campaigns,
                asset=asset,
            )

        with pytest.raises(LiveCheckError, match="validation"):
            prepare_live_check(
                job_id,
                account_id,
                jobs=jobs,
                campaigns=campaigns,
                asset=None,
            )

        database.connection.execute(
            "UPDATE publication_job SET state=? WHERE id=?",
            (JobState.NEEDS_REVIEW.value, job_id),
        )
        database.connection.commit()
        with pytest.raises(LiveCheckError, match="draft"):
            prepare_live_check(
                job_id,
                account_id,
                jobs=jobs,
                campaigns=campaigns,
                asset=asset,
            )
    finally:
        database.close()


def test_rejects_account_that_does_not_match_the_job(tmp_path: Path) -> None:
    database, job_id, account_id, asset = _prepared(tmp_path)
    try:
        with pytest.raises(LiveCheckError, match="does not match"):
            prepare_live_check(
                job_id,
                account_id.replace("instagram", "facebook"),
                jobs=JobRepository(database),
                campaigns=CampaignRepository(database),
                asset=asset,
            )
    finally:
        database.close()
