#!/bin/bash

### Create a volumes through disk utility named CaseSensitive
# Open Disk Utility
# Select + next to volume
# Create an APFS Case-sensitive Volume and name it
# Voilat
sh ./programs.sh
sh ./macos.sh

# run stow to create a symlink of dotfiles as it is the home directory
# everything is linked but bootstrap folder misc folder (.stow-local-ignore) and default ignored
# https://www.gnu.org/software/stow/manual/html_node/Types-And-Syntax-Of-Ignore-Lists.html
stow . --target="$HOME"

mkdir /Volumes/CaseSensitive/wa
mkdir /Volumes/CaseSensitive/src

ln -sv /Volumes/CaseSensitive/wa ~/wa
ln -sv /Volumes/CaseSensitive/src ~/src
ln -sv ~ ~/Desktop
