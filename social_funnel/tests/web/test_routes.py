from datetime import date
from pathlib import Path

from fastapi.testclient import TestClient

from social_funnel.web.app import WebSettings, create_app


CATALOG = Path(__file__).parents[2] / "content" / "fasttrack-30-day-launch.json"


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
    assert "Running" in client.get("/").text


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
