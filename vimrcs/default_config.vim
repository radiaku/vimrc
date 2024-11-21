let data_dir = expand('~/.vimrc_runtime')

" Check if plug.vim exists, if not, download it
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo ' . data_dir . '/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

" Start vim-plug
call plug#begin('~/.vimrc_runtime/plugged')

" List your plugins here
" Plug 'airblade/vim-gitgutter'
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
Plug 'dracula/vim'
Plug 'tpope/vim-commentary'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'justmao945/vim-clang'
Plug 'rupurt/vim-mql5'
Plug 'ap/vim-buftabline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'morhetz/gruvbox'
call plug#end()

" Automatically install plugins if they were just added
if empty(glob(data_dir . '/plugged'))
  autocmd VimEnter * PlugInstall --sync | call plug#end() | source $MYVIMRC
endif

