#!/bin/bash

# Show reset times in Singapore unless overridden by the environment.
STATUSLINE_TZ=${STATUSLINE_TZ:-Asia/Singapore}

fmt_remain() {
  local reset_ts=$1
  local now diff d h m parts

  now=$(date +%s)
  diff=$(( reset_ts - now ))

  if (( diff <= 0 )); then
    echo "0m"
    return
  fi

  d=$(( diff / 86400 ))
  h=$(( (diff % 86400) / 3600 ))
  m=$(( (diff % 3600) / 60 ))

  parts=""
  (( d > 0 )) && parts+="${d}d "
  (( h > 0 )) && parts+="${h}hr "
  (( m > 0 )) && parts+="${m}m"
  echo "${parts% }"
}

fmt_reset_at() {
  local reset_ts=$1
  local day_start tomorrow_start

  # Compare the reset time against midnight in the display timezone.
  day_start=$(TZ="$STATUSLINE_TZ" date -d 'today 00:00' +%s)
  tomorrow_start=$(( day_start + 86400 ))

  # In Bash, printing text is how a function "returns" a string result.
  if (( reset_ts < tomorrow_start )); then
    echo "today $(TZ="$STATUSLINE_TZ" date -d "@$reset_ts" '+%H:%M')"
  else
    echo "$(TZ="$STATUSLINE_TZ" date -d "@$reset_ts" '+%a %H:%M')"
  fi
}

# Read one tab-separated line from jq into shell variables.
IFS=$'\t' read -r \
  model max pct rl5h rl5h_resets rl7d rl7d_resets \
  < <(jq -r '
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

pct_int=${pct%.*}
rl5h_int=${rl5h%.*}
rl7d_int=${rl7d%.*}

used=$(( (max * pct_int) / 100 ))
used_k=$(( used / 1000 ))
max_k=$(( max / 1000 ))

bar_width=16
bar_filled=$(( (pct_int * bar_width) / 100 ))
bar_empty=$(( bar_width - bar_filled ))
bar="[$(printf '█%.0s' $(seq 1 $bar_filled 2>/dev/null))$(printf '░%.0s' $(seq 1 $bar_empty 2>/dev/null))]"
output="🤖 $model | 🧠 $bar ${used_k}k/${max_k}k (${pct_int}%)"

if [[ -n "$rl5h" ]]; then
  output+=" | ⏱️ ${rl5h_int}% $(fmt_reset_at "$rl5h_resets") ($(fmt_remain "$rl5h_resets"))"
  output+=" | 📅 ${rl7d_int}% $(fmt_remain "$rl7d_resets")"
  output+=" @ $(fmt_reset_at "$rl7d_resets")"
fi

echo "$output"
