from datetime import datetime, timezone
from pathlib import Path

from social_funnel.domain.models import AutomationMode, JobState, LocaleCode, LocalizedContent, MediaAsset, Platform, PublicationJob
from social_funnel.validation.service import validate_job


def content(body="A gentle fasting routine helps you track your day.", locale=LocaleCode.EN, cta="Try FastTrack"):
    return LocalizedContent(day=1, locale=locale, hook="Begin gently", body=body, cta=cta,
                            hashtags=("#FastTrack",), safety_note="Consult a professional if fasting may be unsafe for you.")


def job(locale=LocaleCode.EN, platform=Platform.INSTAGRAM):
    return PublicationJob(id="one", campaign_slug="test", day=1, locale=locale, platform=platform,
                          account_id="en-instagram", automation_mode=AutomationMode.APPROVAL,
                          state=JobState.DRAFT, scheduled_at=datetime.now(timezone.utc),
                          idempotency_key="key", content_revision=1)


def asset(tmp_path, width=1080, height=1350, alt="Fasting timer preview"):
    file = tmp_path / "image.png"
    file.write_bytes(b"image")
    return MediaAsset(path=file, width=width, height=height, checksum="abc",
                      mime_type="image/png", alt_text=alt)


def codes(issues):
    return {issue.code for issue in issues}


def test_blocks_unsafe_claims_and_minor_targeting(tmp_path):
    text = "Guaranteed weight loss. Cure diabetes. Fast for 72 hours, kids!"
    found = codes(validate_job(job(), content(body=text), asset(tmp_path)))
    assert {"guaranteed_outcome", "medical_claim", "prolonged_fasting", "minor_targeting"} <= found


def test_blocks_wrong_locale_missing_cta_alt_media_and_ratio(tmp_path):
    wrong = content(body="Comece sua rotina com calma e acompanhe seu jejum todos os dias.").model_copy(update={"cta": ""})
    found = codes(validate_job(job(), wrong, asset(tmp_path, width=400, height=200, alt="")))
    assert {"wrong_language", "empty_cta", "missing_alt_text", "unsupported_ratio"} <= found
    assert "missing_media" in codes(validate_job(job(), content(), None))


def test_reports_resource_and_private_path_issues(tmp_path):
    found = codes(validate_job(job(), content(body="Open C:\\Users\\me\\secret.png"),
                               asset(tmp_path), screenshot_path=tmp_path / "missing.png",
                               font_path=tmp_path / "missing.ttf"))
    assert {"local_path_leak", "missing_screenshot", "missing_font"} <= found


def test_duplicate_cooldown_and_safe_copy(tmp_path):
    media = asset(tmp_path)
    assert not [x for x in validate_job(job(), content(), media) if x.severity == "error"]
    found = codes(validate_job(job(), content(), media, recently_published_hashes={"abc"}))
    assert "duplicate_cooldown" in found
