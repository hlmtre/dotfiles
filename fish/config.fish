set -x GPG_TTY (tty)
eval (dircolors /home/hlmtre/.dir_colors/dircolors | head -n 1 | sed 's/^LS_COLORS=/set -x LS_COLORS /;s/;$//')
