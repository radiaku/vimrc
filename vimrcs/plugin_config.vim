"""" PLUGIN RELATED TWEAKS
" [1]
map <silent> <leader>ee :NERDTreeToggle<cr>
map <silent> <leader>ef :NERDTreeToggle<cr>

let g:NERDTreeIgnore = ['^node_modules$']
let g:NERDTreeWinSize=30

silent! colorscheme desert  



" Emmet leader key map
let g:user_emmet_leader_key=','

" [9]
" Enable vim-prettier to run in files without requiring the "@format" doc tag
let g:prettier#autoformat = 0
let g:prettier#config#tab_width = 2
let g:prettier#config#trailing_comma = 'es5'
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.html Prettier

set encoding=utf-8

set hidden

set nobackup
set nowritebackup

set cmdheight=2

set updatetime=300

set shortmess+=c

if has("nvim-0.5.0") || has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif


" Use K to show documentation in preview window.
" nnoremap <silent> K :call <SID>show_documentation()<CR>



let g:ackprg = 'rg --vimgrep --type-not sql --smart-case'

let g:ack_autoclose = 1

let g:ack_use_cword_for_empty_search = 1

cnoreabbrev Ack Ack!

nnoremap <Leader>/ :Ack!<Space>
nnoremap <leader>fs :Ack!<Space> 

nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>

nnoremap <S-l> :bnext<CR>
nnoremap <S-h> :bprevious<CR>

colorscheme gruvbox

let g:NERDTreeQuitOnOpen = 0

" Enable Airline extensions
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#line#enabled = 1
let g:airline#extensions#encoding#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#hunks#enabled = 0

" Set the line format to show full path on the left
let g:airline#extensions#line#format = '%F'

" Remove all information from the right side and reset after buffer switch
let g:airline#extensions#line#right = ''
autocmd BufEnter * let g:airline#extensions#line#right = ''
