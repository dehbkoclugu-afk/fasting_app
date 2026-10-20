"""Safe error categories without remote secret-bearing text."""


class MetaApiError(RuntimeError):
    def __init__(self, category: str, *, retryable: bool = False,
                 reconnect_required: bool = False, container_id: str | None = None):
        super().__init__(category)
        self.category = category
        self.retryable = retryable
        self.reconnect_required = reconnect_required
        self.container_id = container_id
