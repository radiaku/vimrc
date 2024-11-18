"""" PLUGIN RELATED TWEAKS
" [1]
map <silent> <leader>ee :NERDTreeToggle<cr>

let g:NERDTreeIgnore = ['^node_modules$']
" Increase default width
let g:NERDTreeWinSize=60

" [2]
au BufNewFile,BufRead *.twig set ft=jinja "Syntax highlight twig files

" [4]
silent! colorscheme desert  
" Override cursor bar color (light gray background)
"hi CursorLine cterm=NONE ctermbg=white

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

" [8]
" Set ultisnips triggers
let g:UltiSnipsSnippetsDir='~/.vimrc_runtime/ultisnips-snippets'   " Custom snippets dir
let g:UltiSnipsSnippetDirectories=['ultisnips-snippets'] " Custom snippets dir
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"

" Emmet leader key map
let g:user_emmet_leader_key=','

" [9]
" Enable vim-prettier to run in files without requiring the "@format" doc tag
let g:prettier#autoformat = 0
let g:prettier#config#tab_width = 4
"none" - No trailing commas.
"es5" - Trailing commas where valid in ES5 (objects, arrays, etc.)
"all" - Trailing commas wherever possible (including function arguments). This requires node 8 or a transform.
let g:prettier#config#trailing_comma = 'es5'
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.html Prettier

" [10]

" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
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

" [13]
" Run php-cs-fixer on save
autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()
