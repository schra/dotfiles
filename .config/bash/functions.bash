# Remind myself to not use certain commands.
function rm() {
  # safety measure: I shot myself in the foot with `rm` a couple of times. I
  # should use `gio trash` over `rm` to prevent data loss
  echo ERROR: use gt instead
  return 1
}
function grep() {
  echo ERROR: use rg instead
  return 1
}
function nvim() {
  echo ERROR: use e instead
  return 1
}
# disable autocompletion for nvim
complete -W "" nvim

# *mk*dir and *cd*
function mkcd() {
  # shellcheck disable=SC2164
  mkdir "$1" && cd "$1"
}

# find a file whose name contains a certain string
function find_() {
  find . -iname "*${1}*"
}

# for taking a closer look at a package
function pacwtf() {
  # highlight the packages that require the package
  pacman -Qi "$1" | rg "^Required By.*$" --context=1000 --color=always | less -R
  # remove directories from the output
  pacman -Qql "$1" | rg -v /$ | less
}

_pacwtf() {
  mapfile -t COMPREPLY < <(compgen -W "$(pacman -Qq)" -- "$2")
}
complete -F _pacwtf pacwtf

# Bash completions for my scripts from ~/.local/bin
complete -c mano

# overwrite the rga command
# when I'm using `rga` I want to just find *anything* -> activate all adapters
rga() {
  local all_rga_options
  all_rga_options="$(command rga --rga-list-adapters | sed -En 's/\s+-\s+(.+)/\1/p' | paste -s -d ',')"
  command rga --rga-accurate --rga-adapters="$all_rga_options" "$@"
}

# Automatically use sudo for pacman
# from https://bbs.archlinux.org/viewtopic.php?id=99632
pacman() {
  # I rewrote this without the logical or "|" symbol, because the syntax for
  # Bash and Zsh is different and I want to use this function for both
  if [[ "$1" =~ ^-S[cuy] ]] || [[ "$1" =~ ^-S$ ]] || [[ "$1" =~ ^-R ]] || [[ "$1" =~ ^-U ]]; then
    sudo /usr/bin/pacman "$@"
  else
    command pacman "$@"
  fi
}

# *cd* *p*osts
cdp() {
  local path_=~/Projects/notes/src

  if [ $# -eq 0 ]; then
    cd $path_
  fi

  local file_="$path_/$1"

  if [ -f "$file_" ]; then
    e "$file_"
  else
    cd "$file_"
  fi
}
_cdp() {
  local path_=~/Projects/notes/src
  mapfile -t COMPREPLY < <(compgen -W "$(ls $path_)" -- "$2")
}
complete -F _cdp cdp
