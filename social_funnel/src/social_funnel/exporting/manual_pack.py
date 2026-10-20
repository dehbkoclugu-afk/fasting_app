"""Offline ZIP packs for human-controlled publishing."""

import json
from pathlib import Path
from zipfile import ZIP_DEFLATED, ZipFile

from social_funnel.domain.models import CampaignManifest, Platform
from social_funnel.rendering.images import RenderRequest, render_asset
from social_funnel.rendering.video import render_video
from social_funnel.storage.repositories import JobRepository
from social_funnel.validation.service import validate_job


def export_manual_pack(job_ids: tuple[str, ...], destination: Path, jobs: JobRepository,
                       manifest: CampaignManifest, media_root: Path) -> Path:
    if not job_ids:
        raise ValueError("Select at least one job")
    prepared = []
    for job_id in job_ids:
        job = jobs.get(job_id)
        content = next(item for item in manifest.ideas[job.day - 1].localized if item.locale == job.locale)
        folder = media_root / f"day-{job.day:02d}" / job.locale.value / job.platform.value
        asset = None
        if job.platform != Platform.THREADS:
            request = RenderRequest(content, folder, size=(1080, 1920) if job.platform == Platform.TIKTOK else (1080, 1350))
            if content.preferred_format == "video" or job.platform == Platform.TIKTOK:
                asset = render_video(request)
            else:
                asset = render_asset(RenderRequest(content, folder,
                                                  format="carousel" if content.preferred_format == "carousel" else "image"))
        issues = validate_job(job, content, asset)
        errors = [issue.code for issue in issues if issue.severity == "error"]
        if errors:
            raise ValueError(f"Job {job.id} failed validation: {', '.join(errors)}")
        prepared.append((job, content, asset))
    destination.parent.mkdir(parents=True, exist_ok=True)
    manifest_data = {"campaign": manifest.slug, "jobs": []}
    with ZipFile(destination, "w", ZIP_DEFLATED) as bundle:
        for job, content, asset in prepared:
            prefix = f"{job.locale.value}/{job.platform.value}/day-{job.day:02d}/"
            caption = "\n\n".join((content.hook, content.platform_overrides.get(job.platform, content.body),
                                    content.cta, " ".join(content.hashtags)))
            bundle.writestr(prefix + "caption.txt", caption.encode("utf-8"))
            bundle.writestr(prefix + "alt-text.txt", (asset.alt_text if asset else content.hook).encode("utf-8"))
            if asset:
                for path in (asset.path, *asset.additional_paths):
                    bundle.write(path, prefix + path.name)
            manifest_data["jobs"].append({"id": job.id, "day": job.day, "locale": job.locale.value,
                                          "platform": job.platform.value, "account_id": job.account_id,
                                          "scheduled_at": job.scheduled_at.isoformat()})
        bundle.writestr("manifest.json", json.dumps(manifest_data, ensure_ascii=False, indent=2).encode("utf-8"))
    return destination
