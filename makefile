all: theme

dark:
	make THEME=$@

light:
	make THEME=$@

theme: ~/.theme
	make theme-tig theme-tmux THEME=`cat $^`

~/.theme:
	@test -n "$$THEME" || (echo 'Usage: make <dark|light>' >&2; false)
	echo "$$THEME" > $@

theme-tig:
	erb ~/.tigrc.erb > ~/.tigrc

theme-tmux:
	erb ~/.tmux.conf.erb > ~/.tmux.conf
	test -n "$TMUX" && tmux source ~/.tmux.conf

.PHONY: all dark light theme theme-tig theme-tmux
