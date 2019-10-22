# no need to export vars that are already exported
PATH="$HOME/.local/bin:$PATH"

# for `bat`
export BAT_STYLE=changes

# set default editor
export VISUAL=/usr/bin/nvim
export EDITOR=/usr/bin/nvim

# for React Native
# see https://facebook.github.io/react-native/docs/getting-started
for dir in "$HOME/Android/Sdk" /storage/Android/SDK; do
  if [ -d "$dir" ]; then
    export ANDROID_HOME="$dir"
    PATH="$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools"
    break
  fi
done

# for `make`
# this is especially important for makepkg, i.e. aurman
case $(nproc) in
4)
  # just use all cores since we would otherwise slow down the compilation process too much
  export MAKEFLAGS=" -j4 "
  ;;
12)
  # don't use all cores so that the computer doesn't hang when compiling
  export MAKEFLAGS=" -j9 "
  ;;
esac

# for `ccache`
export CCACHE_MAXSIZE=50G

# color `man`
LESS_TERMCAP_mb=$(printf "\e[1;31m")
LESS_TERMCAP_md=$(printf "\e[1;31m")
LESS_TERMCAP_me=$(printf "\e[0m")
LESS_TERMCAP_se=$(printf "\e[0m")
LESS_TERMCAP_so=$(printf "\e[1;44;33m")
LESS_TERMCAP_ue=$(printf "\e[0m")
LESS_TERMCAP_us=$(printf "\e[1;32m")
export LESS_TERMCAP_mb LESS_TERMCAP_md LESS_TERMCAP_me LESS_TERMCAP_se LESS_TERMCAP_so LESS_TERMCAP_ue LESS_TERMCAP_us
