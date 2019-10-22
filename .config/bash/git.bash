alias g=git
alias ga.='git add .'
alias ga='git add'
alias gap='git add --patch'
alias gau='git add -u'
alias gc='git commit'
alias gca='git commit --amend'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gd='git diff'
alias gds='git diff --staged'
alias gsd=gds # common typo
alias gl='git log'
alias gor='git remote get-url origin'
alias gp='git pull'
alias gr='git rebase'
alias grc='git recent'
alias grs='git reset'
alias gs='git status'
alias gsh='git show'
alias gsh~='git show HEAD~' # show the last commit
alias gst='git stash'

# let's pretend that there is a Git repo in ~
git() {
  if [ "$PWD" = "$HOME" ]; then
    dotfiles "$@"
  else
    command git "$@"
  fi
}

# Edit a file in a repository based on grepping its path.
# ge is for Git Edit
ge() {
  if [ $# -ne 1 ]; then
    echo Usage: ge [search]
    return
  fi

  local matches
  readarray -d '' matches < <(git ls-files -z | rg -i --null-data -- "$1")

  if [ ${#matches[@]} = 1 ]; then
    e "${matches[0]}"
  elif [ ${#matches[@]} = 0 ]; then
    echo Error: Got 0 matches
  else
    echo Error: Got ${#matches[@]} matches:
    printf '%s\n' "${matches[@]}"
  fi
}

# This is not an alias, so that I don't have to escape strings with spaces.
gcm() {
  git commit -m "$*"
}

# *d*otfiles *g*rep case *i*nsenstive
dgi() (
  if [ $# -lt 1 ]; then
    echo Usage: dgi [rg arguments]...
    return
  fi
  source ~/.local/bin/dotfiles-tests-functionality.bash
  # shellcheck disable=SC2154
  rgi "$@" "${fs_files[@]}"
)