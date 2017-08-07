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
    a=$(echo "$gitsall" | grep "^A ")
    s=$(echo "$gitsall" | grep "^M ")
    #i=0
    #while [[ -n "$(echo {m,d,u}$(($i)))" ]]; do
#	i=$(($i+1))
#	unset {m,d,u}$(($i))
#    done
    count=1
    while read -r tmpfilename; do
	tmpfilename=${tmpfilename:2}
	set m$(($count))="$(pwd)/$tmpfilename"
	count=$(($count+1))
    done <<< "$m"
    count=1
    while read -r tmpfilename; do
	tmpfilename=${tmpfilename:2}
	set d$(($count))="$(pwd)/$tmpfilename"
	count=$(($count+1))
    done <<< "$d"
    count=1
    while read -r tmpfilename; do
	tmpfilename=${tmpfilename:3}
	set u$(($count))="$(pwd)/$tmpfilename"
	count=$(($count+1))
    done <<< "$u"
    count=1
    while read -r tmpfilename; do
	tmpfilename=${tmpfilename:3}
	set a$(($count))="$(pwd)/$tmpfilename"
	count=$(($count+1))
    done <<< "$a"
    count=1
    while read -r tmpfilename; do
	tmpfilename=${tmpfilename:3}
	set s$(($count))="$(pwd)/$tmpfilename"
	count=$(($count+1))
    done <<< "$s"

    unset m d u a s tmpfilename gitsall
}
