all: theme

help:
	@echo 'Usage: make <dark|light>' >&2

dark:
	make THEME=$@

light:
	make THEME=$@

theme: ~/.theme
	make theme-tig theme-tmux THEME=`cat $^`

~/.theme:
	@test -n "$$THEME" || (make help; false)
	echo "$$THEME" > $@

theme-tig:
	erb ~/.tigrc.erb > ~/.tigrc

theme-tmux: ~/.tmux/plugins/tpm
	erb ~/.tmux.conf.erb > ~/.tmux.conf
	test -n "$TMUX" && tmux source ~/.tmux.conf

~/.tmux/plugins/tpm:
	git clone https://github.com/tmux-plugins/tpm $@

.PHONY: all help dark light theme theme-tig theme-tmux
