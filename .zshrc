# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# `autoload` defines the command `compdef`
autoload -Uz compinit
compinit

# load support for bash completion functions
autoload bashcompinit
bashcompinit
complete -F _pacwtf pacwtf

for file in ~/.config/bash/*.bash; do
  . "$file"
done

# see https://stackoverflow.com/questions/15883416/adding-git-branch-on-the-bash-command-prompt
. /usr/share/git/completion/git-prompt.sh
setopt prompt_subst
PS1='%9c%$(__git_ps1 "\ (%s)") \$ '

. /etc/profile.d/autojump.zsh

. /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
. /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
. /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
