# Dotfiles

This repository contains configurations of programs I'm using.

OS             | Desktop Environment              | Editor     | Shell    | Terminal
-------------- | -------------------------------- | ---------- | -------- | -------------
[Arch Linux][] | [i3][] + [Polybar][] + [dmenu][] | [Neovim][] | [Bash][] | [Alacritty][]

[Arch Linux]: https://www.archlinux.org
[i3]: https://i3wm.org
[Polybar]: https://github.com/jaagr/polybar
[dmenu]: https://tools.suckless.org/dmenu/
[Neovim]: https://neovim.io
[Bash]: https://www.gnu.org/software/bash
[Alacritty]: https://github.com/jwilm/alacritty

## Highlights

Here are a few of my commands that I especially like:

* `c` (**c**ompile):
  Via `c` I build most of my projects.
* `ge` (**g**it **e**dit):
  Edit a file in a repository based on grepping its path.
  For example, in this repository I can type `ge i3` when I want to edit my i3 configuration because `i3` is a substring of `.config/i3/config` (and this is the only file with that substring).

## Installation

I'm using [dotfiles.sh](https://github.com/alfunx/dotfiles.sh) to maintain this repository.

## Tests

First, install my dotfiles and all test dependencies:

```
pacman -S ripgrep shfmt shellcheck bash-bats
```

Then you can run the tests for my dotfiles like this:

```
dotfiles-tests
```

Sometimes you can also directly apply auto-fixes:

```
dotfiles-apply-autofixes
```

You can also automatically execute the tests before each Git commit:

```
dotfiles-install-hook
```
