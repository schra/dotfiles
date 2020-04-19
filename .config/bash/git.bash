alias g=git
alias ga.='git add .'
alias ga='git add'
alias gap='git add --patch'
alias gau='git add -u'
alias gb='git branch'
alias gbD='git branch -D'
alias gc='git commit'
alias gca='git commit --amend'
alias gcar='git commit --amend --reset-author'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcp='git cherry-pick'
alias gcpA='git cherry-pick --abort'
alias gcpC='git cherry-pick --continue'
alias gd='git diff'
alias gdS='git diff --compact-summary'
alias gds='git diff --staged'
alias gdsS='git diff --staged --compact-summary'
alias gl='git log'
alias gm='git merge'
alias gmA='git merge --abort'
alias gmC='git merge --continue'
alias gor='git remote get-url origin'
alias gp='git pull'
alias gr='git rebase'
alias grA='git rebase --abort'
alias grC='git rebase --continue'
alias grc='git recent'
alias gri='git rebase -i'
alias grm='git rm'
alias grs='git reset'
alias grsH='git reset --hard'
alias gs='git status'
alias gsh='git show'
alias gshS='git show --compact-summary' # Git SHow Summary
alias gsh~='git show HEAD~' # show the last commit
alias gst='git stash'

# let's pretend that there is a Git repo in ~
git() {
  # Bug fix: The dotfiles command overloads "init" and "clone" which will
  # replace the current dotfiles repo with a new repo. When executing "git
  # clone" in $HOME, you probably expect to clone a directory into $HOME and
  # not to replace your dotfiles repo.
  # Note that the dotfiles script itself tests for "init" and "clone" only in
  # the first argument!
  dangerous_dotfiles_overload() {
    [[ $# -ge 1 && ("$1" = init || "$1" = clone) ]]
  }

  if [ "$PWD" = "$HOME" ] && ! dangerous_dotfiles_overload "$@"; then
    dotfiles "$@"
  else
    command git "$@"
  fi
}

# Edit a file in a repository based on grepping its path.
# ge is for Git Edit
ge() {
  if [ $# -eq 0 ]; then
    echo Usage: ge [search..]
    return
  fi

  multigrep() {
    arg=$1
    if [ $# -eq 1 ]; then
      rg -i --null-data "$arg"
    else
      shift
      rg -i --null-data "$arg" | multigrep "$@"
    fi
  }

  local matches
  readarray -d '' matches < <(git ls-files -z | multigrep "$@")

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
# Git Commit Add Message
gcam() {
  git commit -am "$*"
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

# Checkout *G*it*H*ub PR
gh() {
  if [ $# -ne 2 ]; then
    echo Usage: gh [PR ID] [branch name]
    return
  fi

  git fetch origin pull/$1/head:$2 && git checkout $2
}

# clone a git repository and cd into it
gclo() {
  if [ $# -ne 1 ]; then
    echo Usage: glco [url]
    return
  fi

  local dir="$(basename "$1")"
  dir="${dir%.git}"
  git clone "$1" && cd "$dir"
}
