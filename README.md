# Ubuntu development environment (ubuntudevenv)

An Ubuntu linux development envrionment is made, with all usual tools, e.g.

* git and git-lfs
* zulu java 11
* docker command line
* zsh / oh-my-zsh
* personal dotfiles from git repository
* vim
* curl

## docker
docker is setup running via host servers docker daemon. That is docker
commands can be run inside ubuntudevenv.

## Git project
It is foreseen that the git project is extracted from outside, and volumen
mounted to ubuntudevenv  - see `make run`.
