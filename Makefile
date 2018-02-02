all: theme stow

help:
	@echo 'Usage: make <dark|light>' >&2

dark:
	rm -f ~/.theme
	$(MAKE) THEME=$@

light:
	rm -f ~/.theme
	$(MAKE) THEME=$@

theme: ~/.theme
	$(MAKE) theme-xrdb theme-tig theme-tmux theme-newsbeuter THEME=`cat $^`

~/.theme:
	@test -n "$$THEME" || ($(MAKE) help; false)
	echo "$$THEME" > $@

theme-xrdb:
	erb ~/.Xdefaults.erb > ~/.Xdefaults
	if test -n "$$DISPLAY" ; then xrdb ~/.Xdefaults ; fi

theme-tig:
	erb ~/.tigrc.erb > ~/.tigrc

theme-tmux: ~/.tmux/plugins/tpm
	erb ~/.tmux.conf.erb > ~/.tmux.conf
	if test -n "$$TMUX" ; then tmux source ~/.tmux.conf ; fi

theme-newsbeuter:
	erb ~/.newsbeuter/config.erb > ~/.newsbeuter/config

~/.tmux/plugins/tpm:
	git clone https://github.com/tmux-plugins/tpm $@

stow:
	xstow-unlink ~/opt
	cd ~/opt/symlink && xstow-facade ~/opt/install/*
	xstow -t ~/opt -d ~/opt/symlink -v ~/opt/symlink/* -f | sed '/^$$/d'

.PHONY: all help dark light theme theme-tig theme-tmux stow
