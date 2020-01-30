# If not running interactively, don't do anything
[[ $- != *i* ]] && return

for file in ~/.config/bash/*.bash; do
  . "$file"
done

# see https://stackoverflow.com/questions/15883416/adding-git-branch-on-the-bash-command-prompt
. /usr/share/git/completion/git-prompt.sh
PS1='\W$(__git_ps1 " (%s)") \$ '

. /etc/profile.d/autojump.bash

# put the Bash into vi mode
set -o vi
