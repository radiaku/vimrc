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
nnoremap <leader>ff :CtrlP<CR> 
nnoremap <leader>fb :CtrlPBuffer<CR> 

nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>

nnoremap <S-l> :bnext<CR>
nnoremap <S-h> :bprevious<CR>


let g:NERDTreeQuitOnOpen = 0

set laststatus=2


" Enable Lightline
let g:lightline = {}

let g:lightline.active = {
    \ 'left': [['filename', 'modified', ]],
    \ }

function! LightlineFilename()
    return expand('%:p')
endfunction



let g:lightline.component_function = {
            \ 'filename': 'LightlineFilename'}

set laststatus=2

" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlP'

colorscheme gruvbox


" ==== ALE ====
let g:ale_lint_on_text_changed = 'always'
let g:ale_fix_on_save = 0
let g:ale_linters = {
  \ 'python': ['pyright'],
  \ 'go': ['gofmt'],
  \ 'yaml': ['yamllint']
  \ }
let g:ale_fixers = {
  \ 'python': ['autopep8'],
  \ 'go': ['gofmt'],
  \ '*': ['remove_trailing_lines', 'trim_whitespace']
  \ }
let g:ale_python_flake8_options = '--ignore=E501,E402,F401,E701,E711,E712' " ignore long-lines, import on top of the file, unused modules and statement with colon
let g:ale_python_autopep8_options = '--ignore=E501'              " ignore long-lines for autopep8 fixer
let g:ale_yaml_yamllint_options='-d "{extends: relaxed, rules: {line-length: disable}}"'

" let g:airline#extensions#ale#enabled = 1
let g:ale_sign_warning = "\uf421" "  
let g:ale_sign_error = "\uf658" "  

let g:ale_echo_msg_format = '[%linter%] %code%: %s'

let g:ale_completion_symbols = {
            \ 'text': '',
            \ 'method': '',
            \ 'function': '',
            \ 'constructor': '',
            \ 'field': '',
            \ 'variable': '',
            \ 'class': '',
            \ 'interface': '',
            \ 'module': '',
            \ 'property': '',
            \ 'unit': 'unit',
            \ 'value': 'val',
            \ 'enum': '',
            \ 'keyword': 'keyword',
            \ 'snippet': '',
            \ 'color': 'color',
            \ 'file': '',
            \ 'reference': 'ref',
            \ 'folder': '',
            \ 'enum member': '',
            \ 'constant': '',
            \ 'struct': '',
            \ 'event': 'event',
            \ 'operator': '',
            \ 'type_parameter': 'type param',
            \ '<default>': 'v'
            \ }

let g:ale_debug = 1
