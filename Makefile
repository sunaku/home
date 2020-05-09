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
	$(MAKE) THEME=$$(cat $^) \
		theme-xrdb \
		theme-tig \
		theme-tmux \
		theme-kitty \
		theme-newsboat

~/.theme:
	@test -n "$$THEME" || ($(MAKE) help; false)
	echo "$$THEME" > $@

theme-xrdb:
	erb ~/.Xdefaults.erb > ~/.Xdefaults
	if test -n "$$DISPLAY" ; then xrdb -merge ~/.Xdefaults ; fi

theme-tig:
	erb ~/.tigrc.erb > ~/.tigrc

theme-tmux: ~/.tmux/plugins/tpm
	erb ~/.tmux.conf.erb > ~/.tmux.conf
	if test -n "$$TMUX" ; then tmux source ~/.tmux.conf ; fi

theme-kitty: ~/.config/kitty/kitty.conf.erb
	erb ~/.config/kitty/kitty.conf.erb > ~/.config/kitty/kitty.conf

theme-newsboat:
	erb ~/.newsboat/config.erb > ~/.newsboat/config

~/.tmux/plugins/tpm:
	git clone https://github.com/tmux-plugins/tpm $@

stow: opt/symlink
	$(MAKE) -C $<

.PHONY: all help dark light theme theme-tig theme-tmux stow
