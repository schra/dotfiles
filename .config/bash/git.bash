alias g=git
alias ga.='git add .'
alias ga='git add'
alias gap='git add --patch'
alias gau='git add -u'
# Untracked files are not shown in "git diff" by default. Via "gan" you can add
# an empty file to the index, thus showing the file in "git diff".
alias gan='git add --intent-to-add'
alias gana='git add --intent-to-add --all'
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
alias glf='git log --follow'
alias glfp='git log --follow --patch'
alias glp='git log --patch'
alias glS='git log --compact-summary'
alias gm='git merge'
alias gmA='git merge --abort'
alias gmC='git merge --continue'
# If you have a submodule where only a branch name is specified, you also want
# to always pull submodules!
alias gp='git pull --recurse-submodules'
alias gr='git rebase'
alias grA='git rebase --abort'
alias grC='git rebase --continue'
alias grc='git recent'
alias gre='git remote'
alias gregu='git remote get-url'
alias greguo='git remote get-url origin'
alias gri='git rebase -i'
alias grm='git rm'
alias grs='git reset'
alias grsH='git reset --hard'
alias gs='git status'
alias gsh='git show'
alias gshS='git show --compact-summary' # Git SHow Summary
alias gsh~='git show HEAD~'             # show the last commit
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

# zsh-specific: zsh might have the alias ge for grep-excuses. so undefine the
# alias before defining the function ge
unalias ge 2>/dev/null

# Edit a file in a repository based on grepping its path.
# ge is for Git Edit
ge() {
  if [ $# -eq 0 ]; then
    echo "Usage: ge [search..]"
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
  if [ $# -eq 2 ]; then
    remote=origin
    pr=$1
    branch=$2
  elif [ $# -eq 3 ]; then
    remote=$1
    pr=$2
    branch=$3
  else
    echo "Usage: gh [REMOTE-NAME] PR-ID BRANCH-NAME"
    return
  fi

  git fetch "$remote" "pull/$pr/head:$branch" && git checkout "$branch"
}

# clone a git repository and cd into it
gclo() {
  if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    echo "Usage: glco url [repo name]"
    return
  fi

  if [ $# -eq 1 ]; then
    local dir
    dir="$(basename "$1")"
    dir="${dir%.git}"
  else
    local dir="$2"
  fi

  git clone --recurse-submodules "$1" "$dir" && cd "$dir"
}
