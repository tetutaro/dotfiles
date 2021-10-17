
colorBG="00/00/00"
colorBg="11/14/1a"
colorBf="21/27/33"
colorBF="32/3b/4d"
colorFG="c3/ca/d9"
colorFg="95/9a/a6"
colorB1="5a/42/66"
colorB2="66/5a/42"
colorB3="42/66/4e"
colorB4="42/4e/66"
colorB5="42/42/66"
colorF1="bf/8d/d8"
colorF2="cc/9c/84"
colorF3="bf/bf/7c"
colorF4="74/b3/74"
colorF5="7c/bf/bf"
colorF6="95/b0/e6"
colorF7="9d/9d/f2"

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
put_template 0  $colorBG
put_template 1  $colorF1
put_template 2  $colorF4
put_template 3  $colorF3
put_template 4  $colorF6
put_template 5  $colorF7
put_template 6  $colorF5
put_template 7  $colorFG
put_template 8  $colorBG
put_template 9  $colorF1
put_template 10 $colorF4
put_template 11 $colorF3
put_template 12 $colorF6
put_template 13 $colorF7
put_template 14 $colorF5
put_template 15 $colorFG

# 256 color space
put_template 16 $colorBg
put_template 17 $colorBf
put_template 18 $colorBF
put_template 19 $colorFg
put_template 20 $colorB1
put_template 21 $colorB2
put_template 22 $colorB3
put_template 23 $colorB4
put_template 24 $colorB5
put_template 25 $colorF2

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg c3cad9 # foreground
  put_template_custom Ph 000000 # background
  put_template_custom Pi c3cad9 # bold color
  put_template_custom Pj 424e66 # selection color
  put_template_custom Pk c3cad9 # selected text color
  put_template_custom Pl c3cad9 # cursor
  put_template_custom Pm 000000 # cursor text
else
  put_template_var 10 $colorFG # foreground
  put_template_var 11 $colorBG # background
  if [ "${TERM%%-*}" = "rxvt" ]; then
    put_template_var 708 $colorBf # internal border (rxvt)
  fi
  put_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset -f put_template
unset -f put_template_var
unset -f put_template_custom
unset colorBG
unset colorBg
unset colorBf
unset colorBF
unset colorFG
unset colorFg
unset colorB1
unset colorB2
unset colorB3
unset colorB4
unset colorB5
unset colorF1
unset colorF2
unset colorF3
unset colorF4
unset colorF5
unset colorF6
unset colorF7
