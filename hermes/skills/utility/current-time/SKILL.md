---
name: current-time
description: "Return the current time for locations such as London, New York, Tokyo, and UTC."
version: 1.0.0
author: dotfiles
license: MIT
dependencies: []
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [time, timezone, utility, test-skill]
---

# Current Time

Use this skill when the user asks for the current time in one or more cities,
countries, or time zones.

This is a test skill. Keep the answer short and return only the requested time
information unless the user asks for extra explanation.

## Procedure

1. Identify the requested locations.
2. Run the helper script from this skill directory:

   ```bash
   python3 scripts/current_time.py london "new york" tokyo
   ```

3. Return the script output directly, or summarize it in one short sentence.

If the user asks for a location that is not in the alias list, ask for the
nearest city or IANA timezone name, such as `Europe/London` or
`America/New_York`.

## Supported Aliases

The helper supports these common names:

| Location | Timezone |
|---|---|
| UTC, GMT | `UTC` |
| London | `Europe/London` |
| New York | `America/New_York` |
| Los Angeles, San Francisco | `America/Los_Angeles` |
| Chicago | `America/Chicago` |
| Denver | `America/Denver` |
| Toronto | `America/Toronto` |
| Paris | `Europe/Paris` |
| Berlin | `Europe/Berlin` |
| Dubai | `Asia/Dubai` |
| Mumbai, Delhi, India | `Asia/Kolkata` |
| Beijing, Shanghai, China | `Asia/Shanghai` |
| Singapore | `Asia/Singapore` |
| Tokyo | `Asia/Tokyo` |
| Seoul | `Asia/Seoul` |
| Sydney | `Australia/Sydney` |

The helper also accepts direct IANA timezone names.

## Examples

```bash
python3 scripts/current_time.py london
python3 scripts/current_time.py "new york" london tokyo
python3 scripts/current_time.py Europe/London America/New_York Asia/Tokyo
```

Example response shape:

```text
London: 2026-06-01 09:15 BST
New York: 2026-06-01 04:15 EDT
Tokyo: 2026-06-01 17:15 JST
```
