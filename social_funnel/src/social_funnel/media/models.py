from pathlib import Path

from pydantic import BaseModel, ConfigDict

from social_funnel.domain.models import LocaleCode


class MediaSlot(BaseModel):
    model_config = ConfigDict(frozen=True)
    day: int
    locale: LocaleCode
    kind: str
    position: int = 0


class ImportedFile(BaseModel):
    model_config = ConfigDict(frozen=True)
    archive_path: str
    normalized_path: str
    slot: MediaSlot
    size: int
    staged_path: Path | None = None
    checksum: str = ""
    width: int | None = None
    height: int | None = None
    duration_ms: int | None = None
    mime_type: str = ""


class ImportIssue(BaseModel):
    model_config = ConfigDict(frozen=True)
    code: str
    message: str
    path: str = ""
    severity: str = "error"


class ImportReport(BaseModel):
    model_config = ConfigDict(frozen=True)
    archive: Path
    files: tuple[ImportedFile, ...] = ()
    issues: tuple[ImportIssue, ...] = ()
    staging_directory: Path | None = None

    @property
    def valid(self) -> bool:
        return not any(issue.severity == "error" for issue in self.issues)
