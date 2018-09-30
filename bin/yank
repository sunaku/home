#!/bin/sh
#
# Usage: yank [FILE...]
#
# Copies the contents of the given files (or stdin if no files are given) to
# the terminal that runs this program.  If this program is run inside tmux(1),
# then it also copies the given contents into tmux's current clipboard buffer.
# If this program is run inside X11, then it also copies to the X11 clipboard.
#
# This is achieved by writing an OSC 52 escape sequence to the said terminal.
# The maximum length of an OSC 52 escape sequence is 100_000 bytes, of which
# 7 bytes are occupied by a "\033]52;c;" header, 1 byte by a "\a" footer, and
# 99_992 bytes by the base64-encoded result of 74_994 bytes of copyable text.
#
# In other words, this program can only copy up to 74_994 bytes of its input.
# However, in such cases, this program tries to bypass the input length limit
# by copying directly to the X11 clipboard if a $DISPLAY server is available;
# otherwise, it emits a warning (on stderr) about the number of bytes dropped.
#
# See http://en.wikipedia.org/wiki/Base64 for the 4*ceil(n/3) length formula.
# See http://sourceforge.net/p/tmux/mailman/message/32221257 for copy limits.
# See http://sourceforge.net/p/tmux/tmux-code/ci/a0295b4c2f6 for DCS in tmux.
#
# Written in 2014 by Suraj N. Kurapati <https://github.com/sunaku>
# Also documented at https://sunaku.github.io/tmux-yank-osc52.html

put() {
  esc=$1
  test -n "$TMUX" -o -z "${TERM##screen*}" && esc="\033Ptmux;\033$esc\033\\"
  printf "$esc"
}

put "\033]52;c;!\a" # KiTTY always appends to the clipboard, so clear it first
#https://sw.kovidgoyal.net/kitty/protocol-extensions.html#pasting-to-clipboard

# copy via OSC 52
buf=$( cat "$@" )
len=$( printf %s "$buf" | wc -c ) max=74994
test $len -gt $max && echo "$0: input is $(( len - max )) bytes too long" >&2
put "\033]52;c;$( printf %s "$buf" | head -c $max | base64 | tr -d '\r\n' )\a"

# also copy to tmux
test -n "$TMUX" && tmux set-buffer "$buf" ||:

# also copy via X11
test -n "$DISPLAY" && printf %s "$buf" | { xsel -i -b || xclip -sel c ;} ||:
