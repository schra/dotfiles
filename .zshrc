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
if [ -f /usr/share/git/completion/git-prompt.sh ]; then
  # Arch Linux specific. In Ubuntu this is sourced automatically.
  . /usr/share/git/completion/git-prompt.sh
fi
setopt prompt_subst
PS1='%9c%$(__git_ps1 "\ (%s)") \$ '

if [ -f /etc/profile.d/autojump.zsh ]; then
  # Arch Linux
  . /etc/profile.d/autojump.szh
elif [ -f /usr/share/autojump/autojump.sh ]; then
  # Ubuntu
  . /usr/share/autojump/autojump.sh
fi

for f in /usr/share/zsh/plugins/{zsh-autosuggestions/zsh-autosuggestions,zsh-history-substring-search/zsh-history-substring-search,zsh-syntax-highlighting/zsh-syntax-highlighting}.zsh; do
  [ -f "$f" ] && . "$f"
done
