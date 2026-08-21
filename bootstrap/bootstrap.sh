#!/bin/bash

### Create a volumes through disk utility named CaseSensitive
# Open Disk Utility
# Select + next to volume
# Create an APFS Case-sensitive Volume and name it
# Voilat
sh ./programs.sh
sh ./macos.sh
sh ../misc/macos/install.sh

# run stow to create a symlink of dotfiles as it is the home directory
# everything is linked but bootstrap folder misc folder (.stow-local-ignore) and default ignored
# https://www.gnu.org/software/stow/manual/html_node/Types-And-Syntax-Of-Ignore-Lists.html
#
# --no-folding: without this, on a machine where ~/.config doesn't exist yet,
# stow collapses the whole directory into one symlink back into this repo, so
# every app that later writes into ~/.config/* (composer, gcloud, etc.) writes
# straight into the git working tree. Forcing per-file symlinks keeps
# ~/.config a real directory, with only the curated files linked in.
stow --no-folding . --target="$HOME"

mkdir /Volumes/CaseSensitive/wa
mkdir /Volumes/CaseSensitive/src

ln -sv /Volumes/CaseSensitive/wa ~/wa
ln -sv /Volumes/CaseSensitive/src ~/src
ln -sv ~ ~/Desktop
