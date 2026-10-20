"""Normalized TikTok failures without token-bearing diagnostics."""


class TikTokApiError(RuntimeError):
    def __init__(self, category: str, *, retryable: bool = False, reconnect_required: bool = False):
        super().__init__(category)
        self.category = category
        self.retryable = retryable
        self.reconnect_required = reconnect_required
