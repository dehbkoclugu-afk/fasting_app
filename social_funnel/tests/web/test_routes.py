from datetime import date
from io import BytesIO
from pathlib import Path
from zipfile import ZipFile

from fastapi.testclient import TestClient
from PIL import Image

from social_funnel.web.app import WebSettings, create_app


CATALOG = Path(__file__).parents[2] / "content" / "fasttrack-30-day-launch.json"


def csrf_from(page: str) -> str:
    import re
    return re.search(r'name="csrf" value="([^"]+)"', page).group(1)


def image_zip() -> bytes:
    png = BytesIO()
    Image.new("RGB", (1080, 1350), "white").save(png, "PNG")
    output = BytesIO()
    with ZipFile(output, "w") as bundle:
        bundle.writestr("day-04/tr/post.png", png.getvalue())
    return output.getvalue()


def test_dashboard_and_detail_show_twelve_destinations_and_locales(tmp_path):
    client = TestClient(create_app(WebSettings(workspace=tmp_path, catalog=CATALOG, start_date=date(2026, 10, 20))))
    page = client.get("/")
    assert page.status_code == 200
    assert "360 jobs" in page.text
    assert "12 destinations" in page.text
    assert "Instagram" in page.text and "TikTok" in page.text and "Threads" in page.text
    detail = client.get("/days/1")
    assert "İlk haftanı sakin başlat" in detail.text
    assert "Comece sua rotina com calma" in detail.text
    assert "English" in detail.text


def test_mutations_require_csrf_and_pause_persists(tmp_path):
    client = TestClient(create_app(WebSettings(workspace=tmp_path, catalog=CATALOG, start_date=date(2026, 10, 20))))
    assert client.post("/pause").status_code == 403
    page = client.get("/")
    import re
    csrf = re.search(r'name="csrf" value="([^"]+)"', page.text).group(1)
    assert client.post("/pause", data={"csrf": csrf}, follow_redirects=False).status_code == 303
    assert "Paused" in client.get("/").text
    assert client.post("/resume", data={"csrf": csrf}, follow_redirects=False).status_code == 303
    assert "Aktif değil" in client.get("/").text


def test_day_export_returns_download_after_csrf(tmp_path, monkeypatch):
    from social_funnel.web import routes

    def fast_export(job_ids, destination, jobs, manifest, media_root):
        assert len(job_ids) == 12
        destination.parent.mkdir(parents=True, exist_ok=True)
        destination.write_bytes(b"test-zip")
        return destination

    monkeypatch.setattr(routes, "export_manual_pack", fast_export)
    client = TestClient(create_app(WebSettings(workspace=tmp_path, catalog=CATALOG, start_date=date(2026, 10, 20))))
    import re
    csrf = re.search(r'name="csrf" value="([^"]+)"', client.get("/days/1").text).group(1)
    assert client.post("/days/1/export").status_code == 403
    response = client.post("/days/1/export", data={"csrf": csrf})
    assert response.status_code == 200
    assert response.content == b"test-zip"
    assert response.headers["content-disposition"] == 'attachment; filename="day-01.zip"'


def test_media_workspace_requires_csrf_and_rejects_non_zip(tmp_path):
    app = create_app(WebSettings(workspace=tmp_path, catalog=CATALOG, start_date=date(2026, 10, 20)))
    client = TestClient(app)
    assert "Aylık medya yükle" in client.get("/media").text
    assert client.post("/media/preflight", files={"archive": ("bad.txt", b"bad", "text/plain")}).status_code == 403
    csrf = csrf_from(client.get("/media").text)
    response = client.post("/media/preflight", data={"csrf": csrf}, files={"archive": ("bad.txt", b"bad", "text/plain")})
    assert response.status_code == 400
    assert "ZIP" in response.text


def test_media_preflight_does_not_activate_until_explicit_action(tmp_path):
    app = create_app(WebSettings(workspace=tmp_path, catalog=CATALOG, start_date=date(2026, 10, 20)))
    client = TestClient(app)
    csrf = csrf_from(client.get("/media").text)
    response = client.post("/media/preflight", data={"csrf": csrf}, files={"archive": ("month.zip", image_zip(), "application/zip")}, follow_redirects=False)
    assert response.status_code == 303
    assert app.state.media_imports.active_batch("fasttrack-30-day-launch") is None
    batch_id = response.headers["location"].split("batch=")[1]
    page = client.get(response.headers["location"])
    assert "1 / 90 içerik yuvası hazır" in page.text
    csrf = csrf_from(page.text)
    activated = client.post(f"/media/{batch_id}/activate", data={"csrf": csrf}, follow_redirects=False)
    assert activated.status_code == 303
    assert app.state.media_imports.active_batch("fasttrack-30-day-launch")["id"] == batch_id


def test_media_rollback_restores_previous_active_batch(tmp_path):
    app = create_app(WebSettings(workspace=tmp_path, catalog=CATALOG, start_date=date(2026, 10, 20)))
    client = TestClient(app)
    repo = app.state.media_imports
    repo.create_batch("one", "fasttrack-30-day-launch", "sha-one")
    repo.create_batch("two", "fasttrack-30-day-launch", "sha-two")
    repo.activate("fasttrack-30-day-launch", "one")
    repo.activate("fasttrack-30-day-launch", "two")
    csrf = csrf_from(client.get("/media").text)
    response = client.post("/media/rollback", data={"csrf": csrf}, follow_redirects=False)
    assert response.status_code == 303
    assert repo.active_batch("fasttrack-30-day-launch")["id"] == "one"


def test_campaign_activation_is_blocked_until_all_videos_exist(tmp_path):
    app = create_app(WebSettings(workspace=tmp_path, catalog=CATALOG, start_date=date(2026, 10, 20)))
    client = TestClient(app)
    csrf = csrf_from(client.get("/").text)
    response = client.post("/campaign/activate", data={"csrf": csrf})
    assert response.status_code == 409
    assert "30 video" in response.text
    assert not app.state.scheduler.active
