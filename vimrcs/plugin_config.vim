"""" PLUGIN RELATED TWEAKS
" [1]
map <silent> <leader>ee :NERDTreeToggle<cr>

let g:NERDTreeIgnore = ['^node_modules$']
let g:NERDTreeWinSize=30

silent! colorscheme desert  

" Show syntax highlighting groups for word under cursor
 :nmap <leader>ss <plug>(SynStack)

" [5]
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher (a lot
" faster than grep)
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_working_path_mode = 'r'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  let g:ctrlp_extensions = ['line']
endif


" Emmet leader key map
let g:user_emmet_leader_key=','

" [9]
" Enable vim-prettier to run in files without requiring the "@format" doc tag
let g:prettier#autoformat = 0
let g:prettier#config#tab_width = 4
let g:prettier#config#trailing_comma = 'es5'
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.html Prettier

set encoding=utf-8

set hidden

set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif


function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction



" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>



" [11]
" Move single lines
nmap <C-k> [e
nmap <C-j> ]e
" Move multiple lines selected
vmap <C-k> [egv
vmap <C-j> ]egv

color dracula

" ack.vim --- {{{

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
