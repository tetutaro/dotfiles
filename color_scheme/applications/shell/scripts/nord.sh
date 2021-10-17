
colorBG="2e/34/40"
colorBg="3b/42/52"
colorBf="43/4c/5e"
colorBF="4c/56/6a"
colorFG="ec/ef/f4"
colorFg="d8/de/e9"
colorB1="7a/3e/44"
colorB2="76/66/46"
colorB3="52/5f/46"
colorB4="2f/40/56"
colorB5="5a/47/56"
colorF1="bf/61/6a"
colorF2="d0/87/70"
colorF3="eb/cb/8b"
colorF4="a3/be/8c"
colorF5="88/c0/d0"
colorF6="5e/81/ac"
colorF7="b4/8e/ad"

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
  put_template_custom Pg eceff4 # foreground
  put_template_custom Ph 2e3440 # background
  put_template_custom Pi eceff4 # bold color
  put_template_custom Pj 2f4056 # selection color
  put_template_custom Pk eceff4 # selected text color
  put_template_custom Pl eceff4 # cursor
  put_template_custom Pm 2e3440 # cursor text
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
