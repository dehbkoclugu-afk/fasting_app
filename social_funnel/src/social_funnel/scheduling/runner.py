"""Wake the local publication queue while the desktop app is running."""

from datetime import datetime, timezone

from apscheduler.schedulers.background import BackgroundScheduler


class SchedulerRunner:
    def __init__(self, service, *, interval_seconds: int = 30, scheduler=None,
                 now=None):
        self.service = service
        self.interval_seconds = interval_seconds
        self.scheduler = scheduler or BackgroundScheduler(timezone="UTC")
        self.now = now or (lambda: datetime.now(timezone.utc))

    def start(self) -> None:
        self.scheduler.add_job(
            self._tick, "interval", seconds=self.interval_seconds,
            id="publication-queue", max_instances=1, coalesce=True,
            replace_existing=True,
        )
        self.scheduler.start()

    def _tick(self) -> None:
        self.service.tick(self.now())

    def shutdown(self) -> None:
        self.scheduler.shutdown(wait=True)
