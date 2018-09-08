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

LS_COLORS='rs=0:di=1;35:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';
export LS_COLORS


umask 002

NORMAL="\[\033[0m\]"
RED="\[\033[31;1m\]"
WHITE="\[\033[37;1m\]"
YELLOW="\[\033[33;1m\]"

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

alias tmux='tmux -2'

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


