# Solarized Dark Color Reference

## Base Colors

| Color  | Hex       | Role                                              |
|--------|-----------|----------------------------------------------------|
| base03 | `#002b36` | Main background                                    |
| base02 | `#073642` | Highlighted/selected background (e.g., current line)|
| base01 | `#586e75` | Comments, secondary content, subtle text           |
| base00 | `#657b83` | (unused in dark mode, body text in light mode)     |
| base0  | `#839496` | Default body text                                  |
| base1  | `#93a1a1` | Emphasized text, headings                          |
| base2  | `#eee8d5` | (unused in dark mode, background in light mode)    |
| base3  | `#fdf6e3` | (unused in dark mode, main background in light mode)|

## Accent Colors

| Color   | Hex       | Typical Usage                          |
|---------|-----------|----------------------------------------|
| yellow  | `#b58900` | Warnings, constants, numbers           |
| orange  | `#cb4b16` | Types, declarations                    |
| red     | `#dc322f` | Errors, deletions                      |
| magenta | `#d33682` | Keywords, special                      |
| violet  | `#6c71c4` | Verbose text, less important keywords  |
| blue    | `#268bd2` | Functions, identifiers                 |
| cyan    | `#2aa198` | Strings, literals                      |
| green   | `#859900` | Additions, success, inserted text      |

## Notes

- In dark mode, `base03`/`base02` are backgrounds, `base0`/`base1` are foreground text.
- In light mode, `base3`/`base2` become backgrounds, `base00`/`base01` become foreground text.
- The 8 accent colors work with both dark and light modes.
