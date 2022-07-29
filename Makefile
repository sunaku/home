THEME_FILE = .themes/background

TEMPLATED_FILES = .tigrc \
		  .tmux.conf \
		  .Xdefaults \
		  .config/kitty/kitty.conf \
		  .newsboat/config \

.PHONY: all
all: stow theme

#-----------------------------------------------------------------------------
# stow
#-----------------------------------------------------------------------------

.PHONY: stow
stow: opt/symlink/
	$(MAKE) -C $<

#-----------------------------------------------------------------------------
# template
#-----------------------------------------------------------------------------

define RENDER_TEMPLATE_TASK =
$(1): $(1).erb $(THEME_FILE)
	env THEME=`cat $(THEME_FILE)` \
		erb $(1).erb > $(1)
	test -s $(1) || rm $(1)
endef

$(foreach t,$(TEMPLATED_FILES),$(eval $(call RENDER_TEMPLATE_TASK,$(t))))

#-----------------------------------------------------------------------------
# theme
#-----------------------------------------------------------------------------

$(THEME_FILE):
	@echo 'Usage: make <dark|light>' >&2; false

.PHONY: dark
dark:
	echo $@ > $(THEME_FILE)
	$(MAKE) theme

.PHONY: light
light:
	echo $@ > $(THEME_FILE)
	$(MAKE) theme

.PHONY: theme
theme: theme-xrdb theme-tmux $(TEMPLATED_FILES)

.PHONY: theme-xrdb
theme-xrdb: .Xdefaults
	if test -n "$$DISPLAY"; then xrdb -merge $<; fi
	-killall -USR1 st
.config/kitty/kitty.conf: .Xdefaults
.Xdefaults: .Xdefaults.d/*.xrdb .Xdefaults.d/*/*.xrdb

.PHONY: theme-tmux
theme-tmux: .tmux.conf .tmux/plugins/tpm
	if test -n "$$TMUX"; then tmux source $<; fi

.tmux/plugins/tpm:
	git clone https://github.com/tmux-plugins/tpm $@

.PHONY: clean
clean:
	find $(TEMPLATED_FILES) -size 0 -exec rm -v {} \;
