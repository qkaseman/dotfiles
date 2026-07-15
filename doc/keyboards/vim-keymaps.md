# Vim-Style Keymaps for Ortholinear Split Keyboards

## Corne (CRKBD, 42-key)

### Miryoku with Vi Nav (`MIRYOKU_NAV=VI`)

The most popular universal ergo layout system. Works on any 36+ key board
including Corne. Enabling the vi nav option gives you hjkl-aligned cursor keys
on the nav layer out of the box.

- **Repo**: [manna-harbour/miryoku](https://github.com/manna-harbour/miryoku)
- **ZMK Corne implementation**:
  [manna-harbour/miryoku_zmk](https://github.com/manna-harbour/miryoku_zmk)
- **Home row mods guide**:
  [precondition.github.io/home-row-mods](https://precondition.github.io/home-row-mods)

Key features:

- 5 columns, 3 rows, 3 thumb keys per hand
- Maximum 1-unit movement from home position
- Home row mods in GACS order (GUI/Alt/Ctrl/Shift, mirrored)
- 6 layers: Base, Nav, Mouse, Num, Sym, Fun
- Left thumbs: Esc/Space/Tab → activate Media/Nav/Mouse
- Right thumbs: Bksp/Enter/Del → activate Num/Sym/Fun
- Enable vi-style nav: set `MIRYOKU_NAV=VI` in `custom_config.h`
- Also available: `MIRYOKU_NAV=INVERTEDT` for inverted-T arrows

### niqodea/crkbd — Clean 4-layer vim layout

Straightforward QWERTY+vim layout with 4 layers max, designed around mnemonics
for learnability.

- **Repo**: [niqodea/crkbd](https://github.com/niqodea/crkbd)
- **Layer diagrams**: PNG images in `images/` directory (layer-0.png through
  layer-3.png)

Vim design choices:

- Arrow keys on hjkl (Layer 2)
- PgDown/PgUp on vim-style `n`/`p` positions
- Brackets `[]` stacked directly above `()` on symbol layer
- Escape replaces Caps Lock (standard vim ergonomic)
- Media layer volume controls mirror vim arrow positions
- Modifiers and layers on thumb cluster
- Uses VIA for configuration ([usevia.app](https://usevia.app))

### qmk-vim — Actual vim modal editing in firmware

Implements real vim Normal/Visual mode directly in QMK. Works on any QMK
keyboard including Corne.

- **Repo**: [andrewjrae/qmk-vim](https://github.com/andrewjrae/qmk-vim) (178
  stars)
- **Author's full keymap** (Kyria, similar to Corne):
  [andrewjrae/kyria-keymap](https://github.com/andrewjrae/kyria-keymap)
- **keymapdb entry**:
  [keymapdb.com/keymaps/andrewjrae](https://keymapdb.com/keymaps/andrewjrae/)

Features:

- Normal mode with hjkl, word motions, line motions
- Visual mode with composable selections
- Composable change/delete/yank with motions (e.g., `dw`, `ci(`)
- `dd`/`cc`/`yy` line operations
- Dot repeat, undo/redo
- Optional text objects
- Numbered jumps
- Colon commands
- Uses ~5% of Atmega32u4 flash

### darren-dooley/corne-config — macOS + vim optimized

- **Repo**:
  [darren-dooley/corne-config](https://github.com/darren-dooley/corne-config)
- **Layer diagrams**: 3 keymap images in README

Vim design choices:

- Layer 2 provides arrow keys on hjkl
- Right two columns on Layer 1 dedicated to bracket pairs `[]`, `{}`, `()`
- Optimized for macOS and vim workflows
- QWERTY base with shifted symbols in standard positions for portability
- Recommends Karabiner-Elements for Caps Lock remapping on macOS

### rafaelromao/keyboards — ZMK, explicitly vim-optimized

- **Repo**: [rafaelromao/keyboards](https://github.com/rafaelromao/keyboards)
- **Documentation site with diagrams**:
  [rafaelromao.github.io/keyboards](https://rafaelromao.github.io/keyboards)

Designed for "software programming with VIM plugins." Uses external ZMK modules
including Leader Key, Adaptive Key, Auto Layer, and Layer Morph. Workflows
organized around: Typing, Numbers, Shortcuts, Navigation (with mouse emulation),
and Programming. Keymap Drawer SVGs at 300 DPI.

### MSNBBC layout (sergioruiiz91) — Vim + Hyprland

- **Repo**:
  [sergioruiiz91/MSNBBC-layout-](https://github.com/sergioruiiz91/MSNBBC-layout-)

Vim + tiling WM design:

- 6 layers: Base, Symbols, Navigation, Mouse, Hyprland WM, Macros
- Arrow keys in hjkl on nav layer (activated via Enter-hold on right thumb)
- Hyprland layer maps Super+hjkl for window focus
- Explicitly rejects home row mods (cites accidental triggers at 90+ wpm)
- "Trident" thumb strategy: Left = Ctrl/Space/Shift, Right = GUI/Backspace/Enter

## Glove80

### sunaku/glove80-keymaps — "Glorious Engrammer" (742 stars)

The standout resource for vim on Glove80. The symbol layer is explicitly
designed around vim operators.

- **Repo**: [sunaku/glove80-keymaps](https://github.com/sunaku/glove80-keymaps)
- **Interactive layer map** (hover over keys):
  [sunaku.github.io/moergo-glove80-keyboard.html#layers](https://sunaku.github.io/moergo-glove80-keyboard.html#layers)
- **MoErgo Layout Editor**:
  [my.moergo.com/glove80/#/layout/user/909a8599-903f-44f3-a51e-5130ecdf2999](https://my.moergo.com/glove80/#/layout/user/909a8599-903f-44f3-a51e-5130ecdf2999)
- **Symbol layer video tour** (vim operators at 10:14):
  [youtube.com/watch?v=uuSR81wc6WQ](https://www.youtube.com/watch?v=uuSR81wc6WQ)
- **Coding demo video**: [youtu.be/fPcO5NGoDao](https://youtu.be/fPcO5NGoDao)
- **Home row mods article**:
  [sunaku.github.io/home-row-mods.html](https://sunaku.github.io/home-row-mods.html)

Symbol layer vim operator placement:

- `^` and `$` on home row (line start/end)
- `#` and `*` grouped (word search forward/backward)
- `{` and `}` for paragraph jumping
- `[` and `]` for previous/next objects
- `?` and `/` stacked vertically (regex search)
- `%` on thumb (matching delimiter jump)
- `:` on middle thumb (command mode entry)
- Backslash on thumb for escaping
- Underscore on most-frequent-letter position for snake_case
- Inward rolls for common bigrams: `()`, `->`, `=>`, `<=`

Architecture:

- 9+ layers (Base/Cursor/Number/Function/Symbol/Mouse/System/Emoji/World)
- Miryoku-inspired with GACS home row mods + bilateral enforcement
- Difficulty levels 1–5 for gradual learning
- Supports Enthium, Engrammer, Engram, QWERTY, Dvorak, Colemak base alphas
- Active Discord channel: `#glorious-engrammer`

### Mathijs-Bakker/glove80-keymaps — Neovim-specific fork

Fork of sunaku's layout with additional Neovim-specific optimizations.

- **Repo**:
  [Mathijs-Bakker/glove80-keymaps](https://github.com/Mathijs-Bakker/glove80-keymaps)

Added vim/Neovim features:

- Swapped Up/Down to match default vi behavior on Cursor, Symbol, and Arrow
  layers
- Harpoon marks mapped to Cursor layer (Backspace + L/D/W/V/Z)
- LSP Diagnostics navigation with severity-based filtering
- Telescope integration for file searching
- Paragraph movement `{`/`}`, jump list nav `Ctrl+O`/`Ctrl+I`
- Forward/backward find with `,` alongside `;`
- Swapped `$`/`#` and `&`/`^` for ergonomic preference

### jcf/digitum — Engrammer on Glove80 (zmk-nix)

- **Repo**: [jcf/digitum](https://github.com/jcf/digitum)

Features:

- 8 layers with Engrammer base
- Per-finger timing for home row mods (180ms index to 270ms pinky)
- App switcher combo (ESC+SPACE = Cmd+Tab)
- "Parang" bracket morphing
- Bilateral enforcement prevents same-hand misfires
- Built for Clojure/Just/Nix stack

## Tools and Resources

### Visualization Tools

| Tool                      | URL                                                                                               | What it does                                                |
| ------------------------- | ------------------------------------------------------------------------------------------------- | ----------------------------------------------------------- |
| Keymap Drawer             | [caksoylar.github.io/keymap-drawer](https://caksoylar.github.io/keymap-drawer)                    | Paste any ZMK/QMK keymap, get SVG visualization             |
| Keymap Drawer (repo)      | [caksoylar/keymap-drawer](https://github.com/caksoylar/keymap-drawer)                             | Install: `pipx install keymap-drawer`                       |
| Glove80 Keymap Visualizer | [pypi.org/project/glove80-keymap-visualizer](https://pypi.org/project/glove80-keymap-visualizer/) | Converts Glove80 ZMK exports to PDF/SVG with color coding   |
| MoErgo Layout Editor      | [my.moergo.com/glove80](https://my.moergo.com/glove80/)                                           | Official Glove80 layout editor, exports ZMK keymaps         |
| keymapdb.com              | [keymapdb.com](https://keymapdb.com)                                                              | Searchable catalog of 146+ visual keymaps (filter by "vim") |

### Design References

| Resource                  | URL                                                                                                                    | Description                                                   |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------- |
| Symbol Layer Design Guide | [getreuer.info/posts/keyboards/symbol-layer/index.html](https://getreuer.info/posts/keyboards/symbol-layer/index.html) | Symbol frequency analysis + vim-aware layer design strategies |
| Home Row Mods Guide       | [precondition.github.io/home-row-mods](https://precondition.github.io/home-row-mods)                                   | Definitive guide to HRM orderings (GASC, GACS, SCGA, CAGS)    |
| keymapdb vim filter       | [keymapdb.com/?q=vim](https://keymapdb.com/?q=vim)                                                                     | All keymaps tagged with vim keybinding scheme                 |

## Recommendations

### For Corne + Vim

1. **Start with Miryoku + `MIRYOKU_NAV=VI`** — battle-tested, hjkl out of the
   box, massive community
2. **Browse niqodea/crkbd** — clean 4-layer visual reference if Miryoku feels
   too opinionated
3. **Consider qmk-vim** — if you want actual modal editing in firmware
   (toggle-able)

### For Glove80 + Vim

1. **Start with sunaku's Glorious Engrammer** — interactive layer map is the
   single best visual resource, symbol layer is purpose-built for vim
2. **Fork Mathijs-Bakker's variant** — if you use Neovim with Harpoon/Telescope
   and want those integrated at the firmware level
