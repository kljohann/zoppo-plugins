plugins:require 'editor' || return 1

(( ${+commands[percol]} )) || return 1

function percol-select-history() {
  local tac
  (( ${+commands[gtac]} )) && tac="gtac" || { (( ${+commands[tac]} )) && tac="tac" || { tac="tail -r" } }
  BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
  CURSOR=$#BUFFER         # move cursor
  zle -R -c               # refresh
}

zle -N percol-select-history
editor:vi:insert:bind 'Control+R' percol-select-history

function ppgrep() {
  local cmd=percol
  (( $+1 )) && set -- --query $1
  ps aux | percol "$@" | awk '{ print $2 }'
}

function pcommit() {
  git log --pretty=format:'%h %ad %s (%an)' --date=short | percol |sed -e "s/^\([a-z0-9]\+\)\s\+.*$/\1/"
}

# vim: ft=zsh sts=2 ts=2 sw=2 et fdm=marker fmr={{{,}}}
