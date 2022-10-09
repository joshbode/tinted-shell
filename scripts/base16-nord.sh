#!/bin/sh
# base16-shell (https://github.com/base16-project/base16-shell)
# Base16 Shell template by base16-project (https://github.com/base16-project)
# Nord scheme by arcticicestudio
export BASE16_THEME=nord

color00="2e/34/40" # Base 00 - Black
color01="bf/61/6a" # Base 08 - Red
color02="a3/be/8c" # Base 0B - Green
color03="eb/cb/8b" # Base 0A - Yellow
color04="81/a1/c1" # Base 0D - Blue
color05="b4/8e/ad" # Base 0E - Magenta
color06="88/c0/d0" # Base 0C - Cyan
color07="e5/e9/f0" # Base 05 - White
color08="4c/56/6a" # Base 03 - Bright Black
color09=$color01 # Base 08 - Bright Red
color10=$color02 # Base 0B - Bright Green
color11=$color03 # Base 0A - Bright Yellow
color12=$color04 # Base 0D - Bright Blue
color13=$color05 # Base 0E - Bright Magenta
color14=$color06 # Base 0C - Bright Cyan
color15="8f/bc/bb" # Base 07 - Bright White
color16="d0/87/70" # Base 09
color17="5e/81/ac" # Base 0F
color18="3b/42/52" # Base 01
color19="43/4c/5e" # Base 02
color20="d8/de/e9" # Base 04
color21="ec/ef/f4" # Base 06
color_foreground="e5/e9/f0" # Base 05
color_background="2e/34/40" # Base 00

if [ -n "$TMUX" ]; then
  # Tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  put_template() { printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_var() { printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_custom() { printf '\033Ptmux;\033\033]%s%s\033\033\\\033\\' $@; }
elif [ "${TERM%%[-.]*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  put_template() { printf '\033P\033]4;%d;rgb:%s\007\033\\' $@; }
  put_template_var() { printf '\033P\033]%d;rgb:%s\007\033\\' $@; }
  put_template_custom() { printf '\033P\033]%s%s\007\033\\' $@; }
elif [ "${TERM%%-*}" = "linux" ]; then
  put_template() { [ $1 -lt 16 ] && printf "\e]P%x%s" $1 $(echo $2 | sed 's/\///g'); }
  put_template_var() { true; }
  put_template_custom() { true; }
else
  put_template() { printf '\033]4;%d;rgb:%s\033\\' $@; }
  put_template_var() { printf '\033]%d;rgb:%s\033\\' $@; }
  put_template_custom() { printf '\033]%s%s\033\\' $@; }
fi

# 16 color space
put_template 0  $color00
put_template 1  $color01
put_template 2  $color02
put_template 3  $color03
put_template 4  $color04
put_template 5  $color05
put_template 6  $color06
put_template 7  $color07
put_template 8  $color08
put_template 9  $color09
put_template 10 $color10
put_template 11 $color11
put_template 12 $color12
put_template 13 $color13
put_template 14 $color14
put_template 15 $color15

# 256 color space
put_template 16 $color16
put_template 17 $color17
put_template 18 $color18
put_template 19 $color19
put_template 20 $color20
put_template 21 $color21

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg e5e9f0 # foreground
  put_template_custom Ph 2e3440 # background
  put_template_custom Pi e5e9f0 # bold color
  put_template_custom Pj 434c5e # selection color
  put_template_custom Pk e5e9f0 # selected text color
  put_template_custom Pl e5e9f0 # cursor
  put_template_custom Pm 2e3440 # cursor text
else
  put_template_var 10 $color_foreground
  if [ "$BASE16_SHELL_SET_BACKGROUND" != false ]; then
    put_template_var 11 $color_background
    if [ "${TERM%%-*}" = "rxvt" ]; then
      put_template_var 708 $color_background # internal border (rxvt)
    fi
  fi
  put_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset -f put_template
unset -f put_template_var
unset -f put_template_custom
unset color00
unset color01
unset color02
unset color03
unset color04
unset color05
unset color06
unset color07
unset color08
unset color09
unset color10
unset color11
unset color12
unset color13
unset color14
unset color15
unset color16
unset color17
unset color18
unset color19
unset color20
unset color21
unset color_foreground
unset color_background

# Optionally export variables
if [ -n "$BASE16_SHELL_ENABLE_VARS" ]; then
  export BASE16_COLOR_00_HEX="2e3440"
  export BASE16_COLOR_01_HEX="3b4252"
  export BASE16_COLOR_02_HEX="434c5e"
  export BASE16_COLOR_03_HEX="4c566a"
  export BASE16_COLOR_04_HEX="d8dee9"
  export BASE16_COLOR_05_HEX="e5e9f0"
  export BASE16_COLOR_06_HEX="eceff4"
  export BASE16_COLOR_07_HEX="8fbcbb"
  export BASE16_COLOR_08_HEX="bf616a"
  export BASE16_COLOR_09_HEX="d08770"
  export BASE16_COLOR_0A_HEX="ebcb8b"
  export BASE16_COLOR_0B_HEX="a3be8c"
  export BASE16_COLOR_0C_HEX="88c0d0"
  export BASE16_COLOR_0D_HEX="81a1c1"
  export BASE16_COLOR_0E_HEX="b48ead"
  export BASE16_COLOR_0F_HEX="5e81ac"
fi
