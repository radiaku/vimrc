" Brief help (https://github.com/junegunn/vim-plug)
" :so % to refresh .vimrc after making changes
" :PlugInstall to install new stuff
" :PlugUpdate to update to latest versions. You can force post-update hooks with :PlugUpdate!
" :PlugClean to remove deleted plugins

call plug#begin('~/.vimrc_runtime/plugged')

" [1] File tree viewer
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Icons in Nerdtree
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Show git status in left bar
Plug 'airblade/vim-gitgutter'
" Show git status in Nerdtree
Plug 'Xuyuanp/nerdtree-git-plugin'

" [3] easily surround things... Nice intro video: https://www.youtube.com/watch?v=5HF4jSyPpvs
Plug 'tpope/vim-surround'

" [4] Themes / Prettify stuff
Plug 'tpope/vim-fugitive'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'
Plug 'felixhummel/setcolors.vim'
Plug 'gko/vim-coloresque'
Plug 'hashivim/vim-vagrant'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'jwalton512/vim-blade'
Plug 'dylnmc/synstack.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'morhetz/gruvbox'
Plug 'jparise/vim-graphql'

" [5] Search filesystem with ctrl+p (this fork replaces the old unmaintained project)
Plug 'ctrlpvim/ctrlp.vim'

" [6]

" [7] Comment out code
Plug 'vim-scripts/tComment' "Comment easily with gcc

" [8] Snippets
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'justinj/vim-react-snippets'
Plug 'mattn/emmet-vim'

" [9] Pretty format for our code
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }

" [10] Linting and LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" [11] Move code
Plug 'tpope/vim-unimpaired'

" [12] Auto close brackets, parenthesis, etc
Plug 'jiangmiao/auto-pairs'

" [13] Format php code
Plug 'stephpy/vim-php-cs-fixer'
Plug 'editorconfig/editorconfig-vim'

call plug#end()
