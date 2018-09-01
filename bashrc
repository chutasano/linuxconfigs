#overrides should go AFTER the source line in ~/.bashrc

#setings, see man bash 1
shopt -s histappend
HISTCONTROL=ignoreboth
HISTSIZE=2000

shopt -s checkwinsize

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

umask 002

NORMAL="\[\033[0m\]"
RED="\[\033[31;1m\]"
WHITE="\[\033[37;1m\]"
SMILEY="${WHITE}:)${NORMAL}"
FROWNY="${RED}:(${NORMAL}"
SELECT="if [ \$? = 0 ]; then echo \"${SMILEY}\"; else echo \"${FROWNY}\"; fi"

PS1="\`${SELECT}\` ${YELLOW}>${NORMAL} "
PS2="   > "

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

#---------------------#
#aliases/functions


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

alias u='sudo apt update && sudo apt upgrade'

#usage: lsx (ls with sort by extension)
alias lx='ls -X'

#usage: c <dir>
function c {
  builtin cd "$@" && ls -F
}

#usage: tmux<n/a> <sessionname>
alias tmuxn='tmux new-session -s '
alias tmuxa='tmux attach-session -t '

#usage; tmuxks (kills current session)
alias tmuxks='tmux kill-session'

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

# usage gitb: shows git branch sorted by last commit date
alias gitb='for k in `git branch|sed s/^..//`;do echo -e `git log -1 --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" "$k" --`\\t"$k";done|sort -r'


# sets up name + email on repo
function gituml {
    git config user.name "Chuta Sano"
    git config user.email "chuta_sano@student.uml.edu"
}

function gitself {
    git config user.name "Chuta Sano"
    git config user.email "chuta_japan@comcast.net"
}

function gitirbt {
    git config user.name "Chuta Sano"
    git config user.email "csano@irobot.com"
}

function gitcmu {
    git config user.name "Chuta Sano"
    git config user.email "csano@cmu.edu"
}


