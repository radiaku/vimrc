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
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jeetsukumaran/vim-indentwise'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mattn/emmet-vim'
Plug 'dusans/vim-hardmode'
" Plug 'jasonccox/vim-wayland-clipboard'
Plug 'ojroques/vim-oscyank'

if !empty(system('go version'))
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
endif
" Plug 'scrooloose/nerdtree'
Plug 'preservim/nerdtree'
" Plug 'terryma/vim-multiple-cursors'
" Plug 'mg979/vim-visual-multi', {'branch': 'master'}
" Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'dense-analysis/ale'
Plug 'prabirshrestha/vim-lsp'
Plug 'rhysd/vim-lsp-ale'
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
Plug 'vim-scripts/AutoComplPop'
Plug 'michaeljsmith/vim-indent-object'
" Plug 'prettier/vim-prettier', {
"   \ 'do': 'npm install',
"   \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }

call plug#end()

" Automatically install plugins if they were just added
if empty(glob(data_dir . '/plugged'))
 autocmd VimEnter * PlugInstall --sync | call plug#end() | source $MYVIMRC
endif

