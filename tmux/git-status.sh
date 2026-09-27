#!/usr/bin/env bash

cd -- "$1" 2>/dev/null || exit 0

status=$(git status --porcelain=v1 --untracked-files=all 2>/dev/null) \
    || exit 0

unstaged=0
staged=0

while IFS= read -r line; do
    [[ -n "$line" ]] || continue

    x=${line:0:1}
    y=${line:1:1}

    case "$x$y" in
        '??')
            ((unstaged += 1))
            ;;
        DD|AU|UD|UA|DU|AA|UU)
            # Unresolved conflicts need separate handling.
            ;;
        *)
            [[ "$x" != ' ' ]] && ((staged += 1))
            [[ "$y" != ' ' ]] && ((unstaged += 1))
            ;;
    esac
done <<< "$status"

printf '📝 unstaged:%d 📦 staged:%d\n' "$unstaged" "$staged"
