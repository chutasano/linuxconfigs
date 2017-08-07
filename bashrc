#usage: open <filename>
alias open='xdg-open' # opens file with default program

#usage: copy < filename OR cat filename | copy
alias copy='xclip -selection clipboard' # copies to clipboard

#usage: gitp  (note: I only use this when I'm just using git as a form of dropbox)
alias gitp='git add -u; git commit -m "auto pushed by gitp"; git push'

#usage: gitd (diff between HEAD and most recent ancestor to master)
alias gitd='git diff $(git merge-base -a HEAD master)'

#usage: c <dir>
function c {
  builtin cd "$@" && ls -F
}

#usage: tmux<n/a> <sessionname>
alias tmuxn='tmux new-session -s '
alias tmuxa='tmux attach-session -t '

#usage: rl (reloads bash)
alias rl='exec bash -l'

#usage gits: sets env variables $m<n> $d<n> $u<n> (modified, deleted, untracked)
function gits {
    git status
    gitsall=$(git status -s)
    m=$(echo "$gitsall" | grep "^ M")
    d=$(echo "$gitsall" | grep "^ D")
    u=$(echo "$gitsall" | grep "^??")
    #i=0
    #while [[ -n "$(echo {m,d,u}$(($i)))" ]]; do
#	i=$(($i+1))
#	unset {m,d,u}$(($i))
#    done
    count=0
    while read -r a; do
	a=${a:2}
	export m$(($count))="$(pwd)/$a"
	count=$(($count+1))
    done <<< "$m"
    count=0
    while read -r a; do
	a=${a:2}
	export d$(($count))="$(pwd)/$a"
	count=$(($count+1))
    done <<< "$d"
    count=0
    while read -r a; do
	a=${a:2}
	export u$(($count))="$(pwd)/$a"
	count=$(($count+1))
    done <<< "$u"
    unset m d u gitsall
}
