#usage: open <filename>
alias open='xdg-open' # opens file with default program

#usage: copy < filename OR cat filename | copy
alias copy='xclip -selection clipboard' # copies to clipboard

#usage: gitp  (note: I only use this when I'm just using git as a form of dropbox)
alias gitp='git add -u; git commit -m "auto pushed by gitp"; git push'

#usage: gitd (diff between HEAD and most recent ancestor to master)
alias gitd='git diff $(git merge-base -a HEAD master)'

#usage: lsd (displays folders)
alias lsd='ls -d */'

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
#credits: https://codereview.stackexchange.com/questions/172324/bash-script-for-referencing-git-status-output-files/173400#173400
function gits {
    git status
    mc=1 dc=1 uc=1 ac=1 sc=1
    local line status path name
    while read -r line; do
        [ "${line}" ] || continue
        status=${line:0:2}
        path=${line:2}
        case "$status" in
            " M") name=m$((mc++)) ;;
            " D") name=d$((dc++)) ;;
            "??") name=u$((uc++)) ;;
            "A ") name=a$((ac++)) ;;
            "M ") name=s$((sc++)) ;;
            *) echo unsupported status on line: $line
        esac
        printf -v $name "$path"
    done <<< "$(git status -s)"
}
