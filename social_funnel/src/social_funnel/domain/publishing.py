"""Publisher boundary; concrete adapters live next to each platform."""

from pathlib import Path
from typing import Protocol, runtime_checkable

from .models import PublicationJob, PublishResult


@runtime_checkable
class Publisher(Protocol):
    def publish(self, job: PublicationJob, asset_path: Path | None) -> PublishResult: ...

    def lookup_by_idempotency_key(self, key: str) -> PublishResult | None: ...
