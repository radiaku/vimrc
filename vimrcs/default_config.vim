let data_dir = expand('~/.vimrc_runtime')

" Check if plug.vim exists, if not, download it
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo ' . data_dir . '/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

" Start vim-plug
call plug#begin('~/.vimrc_runtime/plugged')

" List your plugins here
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

" Automatically install plugins if they were just added
if empty(glob(data_dir . '/plugged'))
  autocmd VimEnter * PlugInstall --sync | call plug#end() | source $MYVIMRC
endif
