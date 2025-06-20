#overrides should go AFTER the source line in ~/.bashrc

#setings, see man bash 1
shopt -s histappend
HISTCONTROL=ignoreboth
HISTSIZE=2000

#I rarely accidentally hit tab, but I do accidentally hit ctrl+i on vim term, which is annoying...
shopt -s no_empty_cmd_completion

shopt -s checkwinsize

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
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

if [[ -n $DOT_WSL ]]
then
    # assumption: running xserver on windows with 0
    export DISPLAY=:0.0
    # assumption: xserver supports this
    export LIBGL_ALWAYS_INDIRECT=1

    # might need to change per launch? investigate
    export DOCKER_TLS_VERIFY=1
    export DOCKER_CERT_PATH=/mnt/c/Users/csano/.docker/machine/machines/default
    export DOCKER_MACHINE_NAME=default
    export DOCKER_HOST=tcp://192.168.99.101:2376
fi

# vim term stuff
if [[ -n "$VIM_TERMINAL" ]]; then
    PROMPT_COMMAND='_vim_sync_PWD'
    function _vim_sync_PWD() {
        printf '\033]51;["call", "Tapi_lcd", "%q"]\007' "$PWD"
    }
    # maybe a bit lazy... should handle multiple args and handle certain flags differently?
    function vim() {
        printf '\033]51;["call", "Tapi_hvim", "%q"]\007' "$1"
    }
    function hvim() {
        printf '\033]51;["call", "Tapi_hvim", "%q"]\007' "$1"
    }
    function jvim() {
        printf '\033]51;["call", "Tapi_jvim", "%q"]\007' "$1"
    }
    function kvim() {
        printf '\033]51;["call", "Tapi_kvim", "%q"]\007' "$1"
    }
    function lvim() {
        printf '\033]51;["call", "Tapi_lvim", "%q"]\007' "$1"
    }
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

export BASH_ENV="${HOME}/.dotaliases"

stty -ixon

OPAMSWITCH=default
