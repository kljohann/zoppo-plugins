zstyle -t ':zoppo:plugin:editor' mode 'vi' || return

zle-keymap-select () {
  local color=7
  if [ $KEYMAP = vicmd ]; then
    zdefault -s ':zoppo:plugin:modecolors' cursor color 4
  fi

  if [[ $TERM == 'screen' ]]; then
    echo -ne '\eP\e]12;'$color'\07\e\\'
  elif [[ -n $TMUX ]]; then
    # See http://article.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324
    echo -ne '\ePtmux;\e\e]12;'$color'\07\e\\'
  elif [[ $TERM != 'linux' ]]; then
    # See man 7 urxvt → XTerm Operating System Commands
    echo -ne '\e]12;'$color'\07'
  fi
}

zle-line-init () {
  if [[ $TERM == 'screen' ]]; then
    echo -ne '\eP\e]12;7\07\e\\'
  elif [[ -n $TMUX ]]; then
    echo -ne '\ePtmux;\e\e]12;7\07\e\\'
  elif [[ $TERM != 'linux' ]]; then
    echo -ne '\e]12;7\07'
  fi
}
zle -N zle-keymap-select
zle -N zle-line-init
