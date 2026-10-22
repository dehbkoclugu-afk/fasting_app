"""Build exact-account publishers from verified identities and vault-backed tokens."""

from collections.abc import Callable
from pathlib import Path

from social_funnel.domain.models import CampaignManifest, PublicationJob
from social_funnel.publishing.meta.client import MetaGraphClient
from social_funnel.publishing.meta.facebook import FacebookPagePublisher
from social_funnel.publishing.meta.instagram import InstagramPublisher
from social_funnel.publishing.meta.threads import ThreadsPublisher
from social_funnel.publishing.tiktok.adapter import TikTokPublisher
from social_funnel.publishing.tiktok.client import TikTokClient
from social_funnel.storage.database import Database
from social_funnel.storage.repositories import AccountConnectionRepository, TikTokStateRepository


class BoundPublisher:
    """Translate a stable local account ID to the provider's immutable ID."""

    def __init__(self, provider_identity: str, publisher):
        self.provider_identity = provider_identity
        self.publisher = publisher

    def lookup_by_idempotency_key(self, key: str):
        return self.publisher.lookup_by_idempotency_key(key)

    def publish(self, job: PublicationJob, asset_path: Path | None):
        provider_job = job.model_copy(update={"account_id": self.provider_identity})
        return self.publisher.publish(provider_job, asset_path)


def build_account_publishers(
    database: Database,
    campaign: CampaignManifest,
    *,
    meta_tokens,
    threads_tokens,
    tiktok_tokens,
    media_url: Callable[[Path], str] | None = None,
    graph_client_factory=MetaGraphClient,
    tiktok_client_factory=TikTokClient,
) -> dict[str, BoundPublisher]:
    def content_lookup(job: PublicationJob):
        return next(
            content for content in campaign.ideas[job.day - 1].localized
            if content.locale == job.locale
        )

    publishers = {}
    for account in AccountConnectionRepository(database).list():
        if not account["enabled"] or not account["provider_identity"]:
            continue
        account_id = account["id"]
        platform = account["platform"]
        if platform == "facebook":
            client = graph_client_factory(meta_tokens.access_token(account_id), version="v25.0")
            publisher = FacebookPagePublisher(client, content_lookup=content_lookup)
        elif platform == "instagram":
            if media_url is None:
                continue
            client = graph_client_factory(meta_tokens.access_token(account_id), version="v25.0")
            publisher = InstagramPublisher(
                client, content_lookup=content_lookup, media_url=media_url,
            )
        elif platform == "threads":
            client = graph_client_factory(
                threads_tokens.access_token(account_id), version="v1.0",
                graph_host="https://graph.threads.net",
            )
            publisher = ThreadsPublisher(
                client, content_lookup=content_lookup, media_url=media_url,
            )
        elif platform == "tiktok":
            client = tiktok_client_factory(tiktok_tokens.access_token(account_id))
            publisher = TikTokPublisher(
                client, content_lookup=content_lookup,
                state=TikTokStateRepository(database),
            )
        else:
            continue
        publishers[account_id] = BoundPublisher(account["provider_identity"], publisher)
    return publishers
