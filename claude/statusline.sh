#!/bin/bash

STATUSLINE_TZ=${STATUSLINE_TZ:-Asia/Singapore}

fmt_remain() {
  local diff=$(( $1 - $(date +%s) ))
  if   (( diff <= 0 ));     then echo "soon"
  elif (( diff < 3600 ));   then echo "$((diff / 60))m"
  elif (( diff < 86400 ));  then echo "$((diff / 3600))h$(( (diff % 3600) / 60 ))m"
  else echo "$((diff / 86400))d$(( (diff % 86400) / 3600 ))h$(( (diff % 3600) / 60 ))m"
  fi
}

fmt_reset_at() {
  local reset_ts=$1
  local day_start tomorrow_start

  day_start=$(TZ="$STATUSLINE_TZ" date -d 'today 00:00' +%s)
  tomorrow_start=$(( day_start + 86400 ))

  if (( reset_ts < tomorrow_start )); then
    TZ="$STATUSLINE_TZ" date -d "@$reset_ts" '+%H:%M'
  else
    TZ="$STATUSLINE_TZ" date -d "@$reset_ts" '+%a %H:%M'
  fi
}

IFS=$'\t' read -r model max pct rl5h rl5h_resets rl7d rl7d_resets < <(jq -r '
  [
    (.model.display_name // "Unknown"),
    (.context_window.context_window_size // 0),
    (.context_window.used_percentage // 0),
    (.rate_limits.five_hour.used_percentage // ""),
    (.rate_limits.five_hour.resets_at // ""),
    (.rate_limits.seven_day.used_percentage // ""),
    (.rate_limits.seven_day.resets_at // "")
  ] | @tsv
')

used=$(( (max * ${pct%.*}) / 100 ))
output="🤖 $model | 🧠 $((used / 1000))k/$((max / 1000))k ${pct%.*}%"

if [[ -n "$rl5h" ]]; then
  output+=" | ⏱️ ${rl5h%.*}% $(fmt_remain "$rl5h_resets") @ $(fmt_reset_at "$rl5h_resets")"
  output+=" | 📅 ${rl7d%.*}% $(fmt_remain "$rl7d_resets") @ $(fmt_reset_at "$rl7d_resets")"
fi

echo "$output"
