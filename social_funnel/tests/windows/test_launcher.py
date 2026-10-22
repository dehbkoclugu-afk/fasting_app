from __future__ import annotations

import socket
import sys
import threading
import time
from datetime import date
from pathlib import Path

from social_funnel.windows.launcher import (
    GracefulShutdown,
    LaunchConfig,
    _server_factory,
    find_local_port,
    launch,
)


def test_find_local_port_skips_an_occupied_port():
    occupied = socket.socket()
    occupied.bind(("127.0.0.1", 0))
    first = occupied.getsockname()[1]
    try:
        chosen = find_local_port((first, first + 1))
    finally:
        occupied.close()

    assert chosen == first + 1


def test_server_factory_supports_windowed_executable_without_console(monkeypatch):
    monkeypatch.setattr(sys, "stdout", None)
    monkeypatch.setattr(sys, "stderr", None)

    server = _server_factory(object(), "127.0.0.1", 8811)

    assert server.config.host == "127.0.0.1"
    assert server.config.port == 8811


def test_launch_binds_localhost_and_opens_browser_after_health(tmp_path):
    workspace = tmp_path / "İçerik Çalışma Alanı"
    catalog = tmp_path / "kampanya.json"
    catalog.write_text("{}", encoding="utf-8")
    events: list[object] = []

    class Server:
        should_exit = False

        def run(self):
            events.append("server-started")

    def server_factory(app, host, port):
        events.append(("server", host, port, app.state.settings.workspace))
        return Server()

    def health_check(url, timeout):
        events.append(("health", url, timeout))
        return True

    result = launch(
        LaunchConfig(workspace=workspace, catalog=catalog, start_date=date(2026, 10, 20), ports=(8811,)),
        app_factory=lambda settings: type("App", (), {"state": type("State", (), {"settings": settings})()})(),
        server_factory=server_factory,
        health_check=health_check,
        browser_open=lambda url: events.append(("browser", url)) or True,
        diagnostic_runner=lambda **_: type("Report", (), {"ok": True, "errors": ()})(),
    )

    assert result == 0
    assert events[0] == ("server", "127.0.0.1", 8811, workspace)
    assert events[-2] == ("health", "http://127.0.0.1:8811/health", 10.0)
    assert events[-1] == ("browser", "http://127.0.0.1:8811/")


def test_launch_reports_diagnostics_without_starting_server(tmp_path):
    messages: list[str] = []

    result = launch(
        LaunchConfig(workspace=tmp_path, catalog=tmp_path / "missing.json", start_date=date.today()),
        diagnostic_runner=lambda **_: type("Report", (), {"ok": False, "errors": ("FFmpeg bulunamadı",)})(),
        message_box=messages.append,
        server_factory=lambda *_: (_ for _ in ()).throw(AssertionError("server must not start")),
    )

    assert result == 1
    assert messages == ["FFmpeg bulunamadı"]


def test_graceful_shutdown_waits_for_active_upload():
    shutdown = GracefulShutdown()
    released = threading.Event()

    def upload():
        with shutdown.upload():
            released.wait(1)

    worker = threading.Thread(target=upload)
    worker.start()
    deadline = time.monotonic() + 1
    while shutdown.in_flight == 0 and time.monotonic() < deadline:
        time.sleep(0.005)

    result: list[bool] = []
    waiter = threading.Thread(target=lambda: result.append(shutdown.shutdown(timeout=0.5)))
    waiter.start()
    time.sleep(0.02)
    assert waiter.is_alive()
    released.set()
    waiter.join(1)
    worker.join(1)

    assert result == [True]

