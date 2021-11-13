### ADDING TO THE PATH
# First line removes the path; second line sets it.  Without the first line,
# your path gets massive and fish becomes very slow.
set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $HOME/Applications $fish_user_paths


### EXPORT ###
set fish_greeting

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
export EDITOR='emacs'
export VISUAL='emacs'
cat ~/.cache/wal/sequences

starship init fish | source
