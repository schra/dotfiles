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
alias gd='git diff'
alias gdS='git diff --compact-summary'
alias gds='git diff --staged'
alias gdsS='git diff --staged --compact-summary'
alias gl='git log'
alias gm='git merge'
alias gor='git remote get-url origin'
alias gp='git pull'
alias gr='git rebase'
alias grc='git recent'
alias gri='git rebase -i'
alias grm='git rm'
alias grs='git reset'
alias gs='git status'
alias gsh='git show'
# show the last commit
alias gsh~='git show HEAD~'
# Git SHow Summary
alias gshS='git show --compact-summary'
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
