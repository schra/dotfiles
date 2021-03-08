# This is stuff I'm using for my dotfile tests.

# Removes elements from in-array and stores the result in out-array
#
# Usage:
#   export -a out-array
#   remove_from_list in-array out-array [elements to remove from in-array]...
remove_from_list() {
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

# List all files in the dotfiles repo existing in the file system.
#
# Usage:
#   export -a out-array
#   dotfiles_real_files out-array
dotfiles_real_files() {
  # ignore false positive
  # shellcheck disable=SC2178
  local -n OUT=$1

  # ignore false positive
  # shellcheck disable=SC2034
  readarray -d '' repo_files < <(dotfiles ls-files -z)

  # Exclude files not existing in the file system and files that are not symlinks
  export -a TMP
  # ignore false positive
  # shellcheck disable=SC2034
  remove_from_list repo_files TMP README.md LICENSE .local/bin/r .local/bin/t .github/workflows/tests.yml
  OUT=("${TMP[@]}")
}

# List all Bash files in the dotfiles repo.
#
# Usage:
#   export -a out-array
#   dotfiles_bash_files out-array
dotfiles_bash_files() {
  # ignore false positive
  # shellcheck disable=SC2178
  local -n OUT=$1

  # ignore false positive
  # shellcheck disable=SC2034
  readarray -d '' candidates < <(dotfiles ls-files .local/bin .config/bash .bashrc .xprofile -z)

  export -a TMP
  # Remove all non-Bash files. Exclude dotfiles-tests as long as shfmt doesn't
  # support Bats syntax
  #
  # ignore false positive
  # shellcheck disable=SC2034
  remove_from_list candidates TMP .local/bin/active-terminal-cwd .local/bin/active-window-pid .local/bin/windows.py .config/bash/np.py .local/bin/dotfiles-tests
  OUT=("${TMP[@]}")
}

dotfiles_root() {
  dotfiles rev-parse --show-toplevel
}

formatter() {
  # -i = number of spaces for indentation
  shfmt -i 2 "$@"
}

static_analyzer() {
  # SC1090, SC1091: Shellcheck shouldn't follow sourced files.
  #
  # SC2164: Shellcheck proposes to add a "|exit" after each "cd" command. But
  # since I'm using "set -Eeuo pipefail" in every script, "cd" will fail
  # anyway.
  #
  shellcheck -s bash -e SC1090,SC1091,SC2164 "$@"
}
