# This is stuff I'm using for my dotfile tests.

# Removes elements from in-array and stores the result in out-array
# Usage: in-array out-array [elements to remove from in-array]...
set_minus() {
  local -n IN=$1
  local -n OUT=$2

  OUT=()
  for i in "${IN[@]}"; do
    append=yes
    for p in "$@"; do
      if [ "$p" = "$i" ]; then
        append=no
        break
      fi
    done

    if [ $append = yes ]; then
      OUT+=("$i")
    fi
  done
  return 0
}

# Make operations relative to the dotfiles folder. I expect that $HOME is the
# folder where the dotfiles are installed
# shellcheck disable=SC2164
cd

# shellcheck disable=SC2034
readarray -d '' all_files < <(dotfiles ls-files -z)

# shellcheck disable=SC2034
# files existing in the file system and files that are not symlinks
export -a fs_files
set_minus all_files fs_files README.md LICENSE .local/bin/r .local/bin/t

# list only *Bash* scripts here, because shellcheck doesn't support zsh
bash_files=(.local/bin/* .config/bash/* .bashrc .xprofile)

export -a home_files
set_minus fs_files home_files .local/bin/dotfiles-tests .local/bin/docker-spotify

formatter() {
  local -a files
  # remove bats tests since shfmt can't process bats files
  set_minus bash_files files .local/bin/dotfiles-tests
  shfmt "$@" -i 2 "${files[@]}" .zshrc
}

# shellcheck disable=SC2120
static_analyzer() {
  shellcheck "$@" -s bash -e SC1090,SC1091 "${bash_files[@]}"
  true
}
