" Brief help (https://github.com/junegunn/vim-plug)
" :so % to refresh .vimrc after making changes
" :PlugInstall to install new stuff
" :PlugUpdate to update to latest versions. You can force post-update hooks with :PlugUpdate!
" :PlugClean to remove deleted plugins

call plug#begin('~/.vimrc_runtime/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'machakann/vim-highlightedyank'
Plug 'mileszs/ack.vim'
Plug 'morhetz/gruvbox'
Plug 'dracula/vim'

call plug#end()
