#!/bin/bash
############################
# .make.sh
# Shamelessly stolen from http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/
# This script creates symlinks from the home directory to any desired dot_files in ~/dot_files
############################

########## Variables

dir=~/dot_files        # dot_files directory
olddir=~/dot_files_old # old dot_files backup directory

files=".bashrc .emacs .emacs.d .profile .scripts .vimrc .xmobarrc .xmonad .xsession" # list of files to make symlinks.

##########

# create dot_files_old in homedir
echo "Creating $olddir for backup of any existing dot_files in ~"
mkdir -p $olddir
echo "...done"

# change to the dot_files directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dot_files in homedir to dot_files_old directory, then create symlinks
for file in $files; do
    echo "Found $file"
    echo "Moving any existing dot_files from ~ to $olddir"
    mv ~/$file ~/dot_files_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/$file
done
