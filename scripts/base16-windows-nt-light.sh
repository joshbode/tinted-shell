#!/bin/sh
# base16-shell (https://github.com/base16-project/base16-shell)
# Base16 Shell template by base16-project (https://github.com/base16-project)
# Windows NT Light scheme by Fergus Collins (https://github.com/C-Fergus)
export BASE16_THEME=windows-nt-light

color00="ff/ff/ff" # Base 00 - Black
color01="80/00/00" # Base 08 - Red
color02="00/80/00" # Base 0B - Green
color03="80/80/00" # Base 0A - Yellow
color04="00/00/80" # Base 0D - Blue
color05="80/00/80" # Base 0E - Magenta
color06="00/80/80" # Base 0C - Cyan
color07="80/80/80" # Base 05 - White
color08="c0/c0/c0" # Base 03 - Bright Black
color09=$color01 # Base 08 - Bright Red
color10=$color02 # Base 0B - Bright Green
color11=$color03 # Base 0A - Bright Yellow
color12=$color04 # Base 0D - Bright Blue
color13=$color05 # Base 0E - Bright Magenta
color14=$color06 # Base 0C - Bright Cyan
color15="00/00/00" # Base 07 - Bright White
color16="ff/ff/00" # Base 09
color17="00/ff/00" # Base 0F
color18="ea/ea/ea" # Base 01
color19="d5/d5/d5" # Base 02
color20="a0/a0/a0" # Base 04
color21="40/40/40" # Base 06
color_foreground="80/80/80" # Base 05
color_background="ff/ff/ff" # Base 00

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
  put_template_custom Pg 808080 # foreground
  put_template_custom Ph ffffff # background
  put_template_custom Pi 808080 # bold color
  put_template_custom Pj d5d5d5 # selection color
  put_template_custom Pk 808080 # selected text color
  put_template_custom Pl 808080 # cursor
  put_template_custom Pm ffffff # cursor text
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
  export BASE16_COLOR_00_HEX="ffffff"
  export BASE16_COLOR_01_HEX="eaeaea"
  export BASE16_COLOR_02_HEX="d5d5d5"
  export BASE16_COLOR_03_HEX="c0c0c0"
  export BASE16_COLOR_04_HEX="a0a0a0"
  export BASE16_COLOR_05_HEX="808080"
  export BASE16_COLOR_06_HEX="404040"
  export BASE16_COLOR_07_HEX="000000"
  export BASE16_COLOR_08_HEX="800000"
  export BASE16_COLOR_09_HEX="ffff00"
  export BASE16_COLOR_0A_HEX="808000"
  export BASE16_COLOR_0B_HEX="008000"
  export BASE16_COLOR_0C_HEX="008080"
  export BASE16_COLOR_0D_HEX="000080"
  export BASE16_COLOR_0E_HEX="800080"
  export BASE16_COLOR_0F_HEX="00ff00"
fi
