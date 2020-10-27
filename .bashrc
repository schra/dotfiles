# If not running interactively, don't do anything
[[ $- != *i* ]] && return

for file in ~/.config/bash/*.bash; do
  . "$file"
done

# see https://stackoverflow.com/questions/15883416/adding-git-branch-on-the-bash-command-prompt
if [ -f /usr/share/git/completion/git-prompt.sh ]; then
  # Arch Linux specific. In Ubuntu this is sourced automatically.
  . /usr/share/git/completion/git-prompt.sh
fi
PS1='\W$(__git_ps1 " (%s)") \$ '

if [ -f /etc/profile.d/autojump.bash ]; then
  # Arch Linux
  . /etc/profile.d/autojump.bash
elif [ -f /usr/share/autojump/autojump.sh ]; then
  # Ubuntu
  . /usr/share/autojump/autojump.sh
fi
