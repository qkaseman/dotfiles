# Misc

Miscelaneous things that don't fall into a specific category or that don't have
enough related things to warrant their own `todo` file.

## Repo Hooks

Formatting hooks in this repo. Or maybe just hooks inside `nvim` that are a
general global? But then it would need to be lines I touch to not screw things
up, so repo-specific prob better.

## `fzf` command line completion

Should work but doesn't seem to? At least not with `fzf-tab`.

## Sketchybar Light/Dark Theme Swap

Currently sketchybar colors are hardcoded (`0xff005f87` etc.) and don't
respond to system appearance changes. To integrate:

1. Create `sketchybar/colors-dark.sh` and `sketchybar/colors-light.sh`
   exporting color variables (`BAR_COLOR`, `ITEM_COLOR`, etc.)
2. Have `sketchybarrc` source a symlinked `colors.sh`
3. Add a `sketchybar-theme-swap` script (like `alacritty-theme-swap`)
   that swaps the symlink and runs `sketchybar --reload`
4. Call it from `bin/alacritty-theme-swap` alongside tmux-theme-swap

The current neutral blue (`#005f87`) works acceptably in both modes,
so this is low priority.
