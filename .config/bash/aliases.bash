# common typos
alias pamcan=pacman
alias pacan=pacman
alias gpre=grep
# this is due to my function `mkcd`
alias mk=mkdir
alias rp=rg
alias ag=rg

# aliases that overwrite existing behavior
alias ls='ls --color=auto'
alias diff='diff --color=auto'
alias cloc='cloc --exclude-dir=node_modules'
alias df='df -h'
alias du='du -hs'

# Among others, this fixes the backspace on my remote server.
# https://unix.stackexchange.com/questions/67537/prevent-ssh-client-passing-term-environment-variable-to-server
# TODO: Can I remove this after reinstalling my vserver?
alias ssh='TERM=xterm ssh'

# shortcut aliases
alias n='nautilus .'
alias py=python3
alias py2=python2
alias py3=python3
# the last import is for instructions like "np.max"
alias np='py -ic "import math; from numpy import *;import numpy as np;"'
# TODO: rename this. only Git commands should start with g
alias gt='gio trash'
alias la='ls -lah'
alias lahS='ls -lahS'
alias lt='ls -t'
# e for nvim and i for insert mode
alias ei='nvim +startinsert'
alias cr='c && r'
# grep case insensitive
alias rgi='rg -i'
# grep without regex
alias rgf='rg -F'
# this is useful when you also want to search in files that are mentioned in the .gitignore file
alias rgn='rg --no-ignore'
# e for editor. -p means that I open files in vim tabs
alias e='nvim -p'

# The percentage isn't shown until the whole file is loaded. this can be archived by pressing Gg.
# I also could automate this via the paramter +Gg but this isn't something you'd want for large files
#export LESS='-Pslines %lt-%lb (%Pt-%Pb\%) file %f'
alias lessr='LESS="-Pslines %lt-%lb (%Pt-%Pb\%) file %f" less -R' # speak as "lesser"

# *cd* *T*onari
alias cdt='cd ~/Projects/tonari'
alias did='(cdp; e diaries/did.rst)'
