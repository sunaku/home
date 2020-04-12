#!/bin/sh -x

# appearance
. ~/.xprofile
devilspie2 &

# terminal
kitty sh -c 'if tmux has-session; then tmux attach -d; else tmux; fi' &

# window manager
exec startlxqt
