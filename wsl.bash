#override

export DISPLAY=:0.0
export LIBGL_ALWAYS_INDIRECT=1

# wslpath does not allow linux specific path -> windows path; a little hack to get
# around that is to set up a symlink from linux -> windows path ON windows 10 (not
# on linux).

export WIN_HOME_PATH='C:\linux'

# override open for wsl -- defer to win start to figure out what to open
# need to be careful about writing to files though --
unalias open
open() {
    cmd.exe /c start "${WIN_HOME_PATH}\\$(realpath --relative-to="$HOME" "$(pwd)/$1" | sed 's/\//\\/')"
}

