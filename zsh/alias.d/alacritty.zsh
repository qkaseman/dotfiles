# Any args supplied indicates dark to light.
# No args is light to dark.
function alacritty_swap_color_mode() {

  # `light` mode by default with no args
  if [ "${1:-light}" = "light" ]; then
    FROM='dark'
    TO='light'
  else;
    FROM='light'
    TO='dark'
  fi

  # MacOS requires the empty `''` or it will use `-e` as the backup
  # extension which we don't want.
  sed -i '' -e "s/\*${FROM}/\*${TO}/g" ~/.config/alacritty/color/*.yml
}

alias lightmode="alacritty_swap_color_mode light"
alias darkmode="alacritty_swap_color_mode dark"
