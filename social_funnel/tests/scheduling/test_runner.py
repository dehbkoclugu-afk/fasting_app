from datetime import datetime, timezone

from social_funnel.scheduling.runner import SchedulerRunner


class FakeClock:
    def __init__(self):
        self.job = None
        self.started = False
        self.shutdown_wait = None

    def add_job(self, job, trigger, **options):
        self.job = (job, trigger, options)

    def start(self):
        self.started = True

    def shutdown(self, *, wait):
        self.shutdown_wait = wait


class Service:
    def __init__(self):
        self.ticks = []

    def tick(self, now):
        self.ticks.append(now)


def test_runner_ticks_on_interval_and_waits_for_clean_shutdown():
    clock = FakeClock()
    service = Service()
    now = datetime(2026, 10, 22, 12, 30, tzinfo=timezone.utc)
    runner = SchedulerRunner(
        service, interval_seconds=20, scheduler=clock, now=lambda: now,
    )

    runner.start()
    job, trigger, options = clock.job
    job()
    runner.shutdown()

    assert clock.started
    assert trigger == "interval"
    assert options == {
        "seconds": 20, "id": "publication-queue", "max_instances": 1,
        "coalesce": True, "replace_existing": True,
    }
    assert service.ticks == [now]
    assert clock.shutdown_wait is True
