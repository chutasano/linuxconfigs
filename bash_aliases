# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias tmux='tmux -2'



#usage: open <filename>
if [[ -z $DOT_WSL ]]
then
    alias open='xdg-open' # opens file with default program
elif [ $DOT_WSL -eq 1 ]
then
    # todo only works for WSL 1
    export WIN_HOME_PATH='C:\csano'
    open() {
        cmd.exe /c start "${WIN_HOME_PATH}\\$(realpath --relative-to="$HOME" "$(pwd)/$1" | sed 's/\//\\/')"
    }
elif [ $DOT_WSL -eq 2 ]
then
    open() {
      cmd.exe /c start "$(wslpath -w $1)"
    }
fi

#usage: copy < filename OR cat filename | copy
alias copy='xclip -selection clipboard' # copies to clipboard

#usage: gitp  (note: I only use this when I'm just using git as a form of dropbox)
alias gitp='git add -u; git commit -m "auto pushed by gitp"; git push'

#usage: gitd (diff between HEAD and most recent ancestor to master)
alias gitd='git diff $(git merge-base -a HEAD master)'

#usage: lsd (displays folders)
alias lsd='ls -d */'

alias u='sudo apt update && sudo apt upgrade'

#usage: lsx (ls with sort by extension)
alias lx='ls -X'

#usage: c <dir>
#c -n
# for some number n to go up the directory stack
# from: https://unix.stackexchange.com/a/180640
# TODO stack size > 1
# export DIRSTACKMAX=10
c() {
[ "$((${DIRSTACKMAX##*[!0-9]*}0/10))" -gt 0 ] &&
        set -- "$@" "$DIRSTACK"               &&
        DIRSTACK='pwd -P >&3; command cd'     ||
        { command cd "$@" && ls -F; return; }
_q()    while   case "$1" in (*\'*) :   ;;      (*)
                ! DIRSTACK="$DIRSTACK '$2$1'"   ;;esac
        do      set -- "${1#*\'}" "$2${1%%\'*}'\''"
        done
while   [ "$#" -gt 1 ]
do      case    ${1:---} in (-|[!-]*|-*[!0-9]*) : ;;
        (*)     eval "  set $((${1#-}+1))"' "${'"$#}\""
                eval '  set -- "$2"'" $2"'
                        set -- "${'"$1"'}" "$1"'
        ;;esac; _q "$1"; shift
done
eval "  DIRSTACK=; $DIRSTACK    &&"'
        _q "$OLDPWD"            &&
        DIRSTACK=$DIRSTACK\ $1
        set "$?" "${DIRSTACK:=$1}"'" $1
"       3>/dev/null
[ "$(($#-1))" -gt "$DIRSTACKMAX" ] &&
        DIRSTACK="${DIRSTACK% \'/*}"
unset -f _q; return "$1"
}

#usage: tmux<n/a> <sessionname>
alias tn='tmux new-session -s '
alias ta='tmux attach-session -t '

#usage; tmuxks (kills current session)
alias tks='tmux kill-session'

#usage; tmuxks (kills current session)
alias tls='tmux ls'

#usage: rl (reloads bash)
alias rl='exec bash -l'

#usage gits: sets env variables $m<n> $d<n> $u<n> (modified, deleted, untracked)
#credits: https://codereview.stackexchange.com/questions/172324/bash-script-for-referencing-git-status-output-files/173400#173400
function gits {
    git status
    mc=1 dc=1 uc=1 ac=1 sc=1 bc=1
    local line status path name
    while read -r line; do
        [ "${line}" ] || continue
        status=${line:0:2}
        path=${line:2}
        case "$status" in
            " M") name=m$((mc++)) ;;
            "D ") name=d$((dc++)) ;;
            "??") name=u$((uc++)) ;;
            "UU") name=b$((bc++)) ;;
            "A ") name=a$((ac++)) ;;
            "M ") name=s$((sc++)) ;;
            *) echo unsupported status on line: $line
        esac
        printf -v $name "$path"
    done <<< "$(git status -s)"
}

# usage gitb: shows git branch sorted by last commit date
alias gitb='for k in `git branch|sed s/^..//`;do echo -e `git log -1 --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" "$k" --`\\t"$k";done|sort -r'

# usage gitc name (without .git) clones a github repo by me
function gitc {
    if [ -f ~/.ssh/id_rsa/ ] || [ -z "$2"] ; then
        git clone "git@github.com:chuthagoras/$1.git"
    else
        git clone "https://github.com/chuthagoras/$1.git"
    fi
}

# sets up name + email on repo

function gitself {
    git config user.name "Chuta Sano"
    git config user.email "chutasano@gmail.com"
}

function gitcmu {
    git config user.name "Chuta Sano"
    git config user.email "csano@cmu.edu"
}

function gitmcg {
    git config user.name "Chuta Sano"
    git config user.email "chuta.sano@mail.mcgill.ca"
}

# usage C <command> (ignores alias/functions)
alias C='command'



