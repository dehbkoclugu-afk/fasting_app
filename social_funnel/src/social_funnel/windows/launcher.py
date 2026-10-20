"""Desktop entry point for the Windows-local FastTrack workspace."""

from __future__ import annotations

from collections.abc import Callable, Iterable, Iterator
from contextlib import contextmanager
from dataclasses import dataclass
from datetime import date
from pathlib import Path
import os
import socket
import threading
import time
from urllib.request import urlopen
import webbrowser

from social_funnel.web.app import WebSettings, create_app
from social_funnel.windows.diagnostics import run_diagnostics


@dataclass(frozen=True)
class LaunchConfig:
    workspace: Path
    catalog: Path
    start_date: date
    ports: tuple[int, ...] = tuple(range(8811, 8831))
    health_timeout: float = 10.0


class GracefulShutdown:
    def __init__(self) -> None:
        self._condition = threading.Condition()
        self._in_flight = 0
        self._stopping = False

    @property
    def in_flight(self) -> int:
        with self._condition:
            return self._in_flight

    @contextmanager
    def upload(self) -> Iterator[None]:
        with self._condition:
            if self._stopping:
                raise RuntimeError("Application is shutting down")
            self._in_flight += 1
        try:
            yield
        finally:
            with self._condition:
                self._in_flight -= 1
                self._condition.notify_all()

    def shutdown(self, timeout: float = 10.0) -> bool:
        deadline = time.monotonic() + timeout
        with self._condition:
            self._stopping = True
            while self._in_flight:
                remaining = deadline - time.monotonic()
                if remaining <= 0:
                    return False
                self._condition.wait(remaining)
            return True


def find_local_port(ports: Iterable[int]) -> int:
    for port in ports:
        probe = socket.socket()
        try:
            probe.bind(("127.0.0.1", port))
            return port
        except OSError:
            continue
        finally:
            probe.close()
    raise RuntimeError("Kullanılabilir yerel bağlantı noktası bulunamadı")


def _server_factory(app, host: str, port: int):
    import uvicorn
    return uvicorn.Server(uvicorn.Config(app, host=host, port=port, log_level="info"))


def _health_check(url: str, timeout: float) -> bool:
    deadline = time.monotonic() + timeout
    while time.monotonic() < deadline:
        try:
            with urlopen(url, timeout=min(0.5, max(0.05, deadline - time.monotonic()))) as response:
                return response.status == 200
        except OSError:
            time.sleep(0.05)
    return False


def _message_box(message: str) -> None:
    try:
        import ctypes
        ctypes.windll.user32.MessageBoxW(None, message, "FastTrack Social Funnel", 0x10)
    except Exception:
        print(message)


def _default_config() -> LaunchConfig:
    workspace = Path(os.environ.get("LOCALAPPDATA", str(Path.home()))) / "FastTrack Social Funnel"
    catalog = Path(__file__).resolve().parents[3] / "content" / "fasttrack-30-day-launch.json"
    return LaunchConfig(workspace, catalog, date.today())


def launch(
    config: LaunchConfig | None = None,
    *,
    app_factory: Callable[[WebSettings], object] = create_app,
    server_factory: Callable[[object, str, int], object] = _server_factory,
    health_check: Callable[[str, float], bool] = _health_check,
    browser_open: Callable[[str], bool] = webbrowser.open,
    diagnostic_runner: Callable[..., object] = run_diagnostics,
    message_box: Callable[[str], None] = _message_box,
) -> int:
    config = config or _default_config()
    report = diagnostic_runner(workspace=config.workspace)
    if not report.ok:
        message_box("\n".join(report.errors))
        return 1

    port = find_local_port(config.ports)
    app = app_factory(WebSettings(config.workspace, config.catalog, config.start_date))
    server = server_factory(app, "127.0.0.1", port)
    thread = threading.Thread(target=server.run, name="fasttrack-local-server")
    thread.start()
    health_url = f"http://127.0.0.1:{port}/health"
    if not health_check(health_url, config.health_timeout):
        server.should_exit = True
        thread.join(timeout=2)
        message_box("Yerel FastTrack hizmeti başlatılamadı")
        return 1
    browser_open(f"http://127.0.0.1:{port}/")
    if thread.is_alive():
        try:
            thread.join()
        except KeyboardInterrupt:
            server.should_exit = True
            thread.join(timeout=10)
    return 0


if __name__ == "__main__":
    raise SystemExit(launch())

