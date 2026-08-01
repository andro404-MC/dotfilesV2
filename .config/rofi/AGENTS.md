# AGENTS.md

Rofi dotfiles (config, themes, menu scripts). Not a git repo; no build/test/lint. Validate with `rofi -dump-theme -theme <file>` and `bash -n scripts/*`.

## Layout & entry points
- `scripts/` are the real entry points (bound to WM keybinds). Each invokes rofi with an explicit `-theme`; they ignore `config.rasi`'s look.
- `themes/unified.rasi` — full-width list menu. Used by `launcher`, `calc`, `clipboard`, `bzmenu`.
- `themes/applet.rasi` — icon-grid panel on the east edge (6 columns, `"feather"` icon font). Used by `mpd`, `screenshot`, which tweak it via `rofi -theme-str`.
- `colors/tokyonight.rasi` — single source of color truth, `@import`ed by both themes. Edit colors here, not in the themes.

## Gotchas
- `config.rasi` ends with `@theme "/home/untemi/.local/share/rofi/themes/simple-tokyonight.rasi"` — a theme OUTSIDE this repo. Don't hunt for it here; the scripts bypass it with `-theme`.
- unified.rasi maps colors via a `* { ... var(...) }` block; applet.rasi references the tokyonight variables directly (`@background`). Both resolve through the same `colors/tokyonight.rasi`.
- Menu glyphs in scripts and themes are Nerd Font codepoints; applet `element-text` uses the `"feather"` font. If you swap a glyph it must exist in the font that renders it.

## External dependencies (not in this repo)
- `mpd`: `mpc` + a running MPD daemon.
- `screenshot`: `grimshot`, `dunstify` (its countdown uses `dunstify`, not `notify-send`), `xdg-user-dir`.
- `clipboard`: shells out to `~/Scripts/cliphist-rofi.sh` (outside repo).
- `bzmenu`: needs the `bzmenu` binary.

Written for rofi 1.7.3; currently runs under rofi 2.0.0 — keep syntax compatible with both.
