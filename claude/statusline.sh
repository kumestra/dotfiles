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


# Read one tab-separated line from jq into shell variables.
IFS=$'\t' read -r \
  model ctx_size ctx_pct block_pct block_resets_at weekly_pct weekly_resets_at \
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

ctx_pct_int=${ctx_pct%.*}

ctx_used_k=$(( (ctx_size * ctx_pct_int) / 100 / 1000 ))
ctx_size_k=$(( ctx_size / 1000 ))

bar_width=16
bar_filled=$(( (ctx_pct_int * bar_width) / 100 ))
bar_empty=$(( bar_width - bar_filled ))
bar="[$(printf '█%.0s' $(seq 1 $bar_filled 2>/dev/null))$(printf '░%.0s' $(seq 1 $bar_empty 2>/dev/null))]"

echo "Model: $model | Context: $bar ${ctx_used_k}k/${ctx_size_k}k (${ctx_pct_int}%)"

if [[ -n "$block_pct" ]]; then
  printf "Session: %.1f%% | Reset: %s | Weekly: %.1f%% | Weekly Reset: %s\n" \
    "$block_pct" "$(fmt_remain "$block_resets_at")" \
    "$weekly_pct" "$(fmt_remain "$weekly_resets_at")"
fi
