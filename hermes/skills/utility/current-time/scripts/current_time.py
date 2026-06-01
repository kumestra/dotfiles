#!/usr/bin/env python3
"""Print current local times for named locations or IANA time zones."""

from __future__ import annotations

import sys
from datetime import datetime
from zoneinfo import ZoneInfo, ZoneInfoNotFoundError


ALIASES = {
    "utc": "UTC",
    "gmt": "UTC",
    "london": "Europe/London",
    "new york": "America/New_York",
    "nyc": "America/New_York",
    "los angeles": "America/Los_Angeles",
    "la": "America/Los_Angeles",
    "san francisco": "America/Los_Angeles",
    "sf": "America/Los_Angeles",
    "chicago": "America/Chicago",
    "denver": "America/Denver",
    "toronto": "America/Toronto",
    "paris": "Europe/Paris",
    "berlin": "Europe/Berlin",
    "dubai": "Asia/Dubai",
    "mumbai": "Asia/Kolkata",
    "delhi": "Asia/Kolkata",
    "india": "Asia/Kolkata",
    "beijing": "Asia/Shanghai",
    "shanghai": "Asia/Shanghai",
    "china": "Asia/Shanghai",
    "singapore": "Asia/Singapore",
    "tokyo": "Asia/Tokyo",
    "seoul": "Asia/Seoul",
    "sydney": "Australia/Sydney",
}


def normalize_location(value: str) -> tuple[str, str]:
    key = " ".join(value.strip().lower().replace("_", " ").split())
    timezone = ALIASES.get(key, value.strip())
    label = value.strip()

    if key in ALIASES:
        label = key.title()

    return label, timezone


def current_time_line(value: str) -> str:
    label, timezone = normalize_location(value)

    try:
        zoned_now = datetime.now(ZoneInfo(timezone))
    except ZoneInfoNotFoundError:
        return f"{value}: unsupported location or timezone"

    return f"{label}: {zoned_now:%Y-%m-%d %H:%M %Z} ({timezone})"


def main(argv: list[str]) -> int:
    if not argv:
        print("Usage: current_time.py <location-or-timezone> [...]", file=sys.stderr)
        return 2

    for value in argv:
        print(current_time_line(value))

    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
