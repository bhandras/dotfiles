#!/bin/bash

cur=~/dotfiles        # dotfiles directory
old=~/dotfiles_old    # old dotfiles backup directory
files="bashrc vimrc"

mkdir -p $old
cd $cur

for file in $files; do
  echo "Moving any existing dotfiles from ~ to $old"
  mv ~/.$file $old
  echo "Creating symlink to $file in home directory."
  ln -s $cur/$file ~/.$file
done
