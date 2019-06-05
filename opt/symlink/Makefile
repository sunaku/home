all: stow

tidy:
	rm-dangling -f

link: tidy
	stow-facade ../install/*

stow: link
	stow -R */ \
		--ignore='share/info/dir$$' \
		--override='share/man/.+?/' \
		--override='bin/'

.PHONY: tidy link stow
