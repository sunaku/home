#!/bin/sh
# IMPORTANT: This file must be run from a login shell so
# that ~/.profile (which sets up the $PATH) is sourced
# before this point.  Otherwise, this script might fail
# because the programs it executes might not be found.

# appearance
xsetroot -cursor_name left_ptr
xset +fp ~/.fonts ||
#
# XServer XSDL runs in Android, so it needs an
# Android path to my custom ~/.fonts directory
#
# https://github.com/pelya/xserver-xsdl/issues/1
#
xset +fp /sdcard/linux/.fonts
xset fp rehash
xrdb ~/.Xdefaults

# window manager
exec xterm -max
