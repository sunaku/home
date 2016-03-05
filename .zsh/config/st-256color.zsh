if [ "$TERM" = "${0:t:r}" ]; then
  # http://git.suckless.org/st/tree/FAQ#n32
  # this makes the Delete key work properly
  tput smkx

  # enable 24-bit TrueColor in NeoVim
  export NVIM_TUI_ENABLE_TRUE_COLOR=1
fi
