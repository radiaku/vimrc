#!/bin/sh
set -e

cd ~/.vimrc_runtime
cat ~/.vimrc_runtime/vimrcs/basic.vim > ~/.vimrc
echo "Installed the Basic Vim configuration successfully! Enjoy :-)"
