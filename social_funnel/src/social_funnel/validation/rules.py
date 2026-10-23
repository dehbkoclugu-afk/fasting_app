"""Conservative keyword patterns, not medical or language classification."""

import re

from social_funnel.domain.models import LocaleCode


CLAIM_PATTERNS = {
    "guaranteed_outcome": re.compile(r"\b(guaranteed? weight loss|lose \d+ (kg|lbs?)|garantili kilo|perda de peso garantida)\b", re.I),
    "medical_claim": re.compile(r"\b(cure(?:s)?|treat(?:s)?|prevent(?:s)?|tedavi eder|iyileştirir|cura|trata)\b.{0,45}\b(diabetes|disease|obesity|hastalık|diyabet|doença|diabete)\b", re.I),
    "prolonged_fasting": re.compile(r"\b(?:fast for|jejum de|saat oruç)\s*(?:[4-9]\d|\d{3,})\s*(?:hours?|horas?|saat)?\b", re.I),
    "minor_targeting": re.compile(r"\b(kids|children|teens|çocuklar|gençler|crianças|adolescentes)\b", re.I),
    "local_path_leak": re.compile(r"(?:[A-Za-z]:\\|file://|/Users/|/home/)", re.I),
}

LANGUAGE_MARKERS = {
    LocaleCode.TR: re.compile(r"\b(oruç|takip|başla|öğün|hafta|sağlık|ritim|süre)\b", re.I),
    LocaleCode.EN: re.compile(r"\b(fasting|track|begin|start|your|routine|week|day)\b", re.I),
    LocaleCode.PT_BR: re.compile(r"\b(jejum|rotina|comece|acompanhe|semana|saúde|dia)\b", re.I),
}
