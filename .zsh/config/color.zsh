unset LS_COLORS

# add color to man pages using less(1)
# https://unix.stackexchange.com/a/147
export LESS_TERMCAP_mb=$(tput bold; tput setaf 5) # start blink
export LESS_TERMCAP_md=$(tput bold; tput setaf 3) # start bold
export LESS_TERMCAP_me=$(tput sgr0) # turn off bold, blink and underline
#export LESS_TERMCAP_so=$(tput bold; tput setaf 0; tput setab 2) # start standout
export LESS_TERMCAP_se=$(tput rmso; tput sgr0) # stop standout
export LESS_TERMCAP_us=$(tput smul; tput setaf 6) # start underline
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0) # stop underline
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)
