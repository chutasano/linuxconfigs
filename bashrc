#usage: open <filename>
alias open='xdg-open' # opens file with default program

#usage: copy < filename OR cat filename | copy
alias copy='xclip -selection clipboard' # copies to clipboard

#usage: gits
alias gits='git status' # git status

#usage: gitp  (note: I only use this when I'm just using github as a form of dropbox)
alias gitp='git add -A; git commit -m "auto pushed by gitp"; git push'

#usage: c <dir>
function c {
  builtin cd "$@" && ls -F
}

#usage: tmux<n/a> <sessionname>
alias tmuxn='tmux new-session -s '
alias tmuxa='tmux attach-session -t '
