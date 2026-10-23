from io import BytesIO
from pathlib import Path
from zipfile import ZipFile, ZipInfo

import pytest
from PIL import Image

from social_funnel.content.loader import load_campaign
from social_funnel.media.importer import inspect_media_zip, stage_media_zip


CATALOG = Path(__file__).resolve().parents[2] / "content" / "fasttrack-30-day-launch.json"


def archive(tmp_path: Path, entries: dict[str, bytes]) -> Path:
    path = tmp_path / "media.zip"
    with ZipFile(path, "w") as bundle:
        for name, data in entries.items():
            bundle.writestr(name, data)
    return path


def test_inspection_normalizes_one_root_and_maps_known_slots(tmp_path: Path) -> None:
    report = inspect_media_zip(archive(tmp_path, {
        "fasttrack-2026-11/day-01/tr/video.mp4": b"video",
        "fasttrack-2026-11/day-02/en/slide-01.png": b"png",
        "fasttrack-2026-11/day-04/pt-BR/post.png": b"png",
    }), load_campaign(CATALOG))

    assert report.valid
    assert [(item.slot.day, item.slot.locale.value, item.slot.kind, item.slot.position) for item in report.files] == [
        (1, "tr", "video", 0), (2, "en", "carousel_slide", 1), (4, "pt-BR", "image", 0),
    ]


@pytest.mark.parametrize("name", ["../secret.txt", "/day-01/tr/video.mp4", "C:/day-01/tr/video.mp4"])
def test_inspection_rejects_unsafe_paths(tmp_path: Path, name: str) -> None:
    report = inspect_media_zip(archive(tmp_path, {name: b"x"}), load_campaign(CATALOG))
    assert not report.valid
    assert "unsafe_path" in {issue.code for issue in report.issues}


def test_inspection_rejects_symlink_entries(tmp_path: Path) -> None:
    path = tmp_path / "media.zip"
    info = ZipInfo("day-01/tr/video.mp4")
    info.create_system = 3
    info.external_attr = 0o120777 << 16
    with ZipFile(path, "w") as bundle:
        bundle.writestr(info, b"target")
    report = inspect_media_zip(path, load_campaign(CATALOG))
    assert not report.valid
    assert "symlink" in {issue.code for issue in report.issues}


def test_inspection_rejects_duplicate_logical_slots_and_unknown_files(tmp_path: Path) -> None:
    report = inspect_media_zip(archive(tmp_path, {
        "day-01/tr/video.mp4": b"one",
        "day-01/tr/VIDEO.MP4": b"two",
        "notes.txt": b"nope",
    }), load_campaign(CATALOG))
    codes = {issue.code for issue in report.issues}
    assert not report.valid
    assert {"duplicate_slot", "unexpected_file"} <= codes


def test_inspection_enforces_entry_and_expanded_size_limits(tmp_path: Path) -> None:
    too_many = archive(tmp_path, {f"junk-{n}.txt": b"x" for n in range(4)})
    report = inspect_media_zip(too_many, load_campaign(CATALOG), max_entries=3)
    assert "too_many_entries" in {issue.code for issue in report.issues}

    oversized = archive(tmp_path, {"day-01/tr/video.mp4": b"12345"})
    report = inspect_media_zip(oversized, load_campaign(CATALOG), max_expanded_bytes=4)
    assert "archive_too_large" in {issue.code for issue in report.issues}


def test_stage_extracts_only_after_inspection_and_probes_content(tmp_path: Path) -> None:
    image = BytesIO()
    Image.new("RGB", (1080, 1350), "white").save(image, "PNG")
    report = stage_media_zip(
        archive(tmp_path, {"day-04/tr/post.png": image.getvalue()}),
        load_campaign(CATALOG),
        tmp_path / "stage",
    )
    assert report.valid
    assert report.files[0].staged_path.is_file()
    assert (report.files[0].width, report.files[0].height, report.files[0].mime_type) == (1080, 1350, "image/png")


def test_invalid_archive_is_not_extracted(tmp_path: Path) -> None:
    destination = tmp_path / "stage"
    report = stage_media_zip(archive(tmp_path, {"../escape.png": b"bad"}), load_campaign(CATALOG), destination)
    assert not report.valid
    assert not destination.exists()
