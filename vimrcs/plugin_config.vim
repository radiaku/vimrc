"""" PLUGIN RELATED TWEAKS
" [1]

" let g:user_emmet_leader_key='<C-Z>'
let g:user_emmet_leader_key='<C-e>'
map <silent> <leader>ee :NERDTreeToggle<cr>
map <silent> <leader>ef :NERDTreeToggle<cr>

" remove annoying leading ^G
let g:NERDTreeNodeDelimiter = "\u00a0"


" AutoComplPop tab completion configuration
inoremap <expr> <Tab> pumvisible() ? "\<C-y>" : "\<Tab>"

" AutoComplPop navigation mappings
inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"

let g:NERDTreeIgnore = ['^node_modules$']
let g:NERDTreeWinSize=30

" colorscheme set
" silent! colorscheme desert  

" Emmet leader key map
" let g:user_emmet_leader_key=','

" [9]
" Enable vim-prettier to run in files without requiring the "@format" doc tag
let g:prettier#autoformat = 0
let g:prettier#config#tab_width = 2
let g:prettier#config#trailing_comma = 'es5'
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.html Prettier

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


" let g:rg_command = 'rg --vimgrep --type-not sql --smart-case --glob=\!.git --glob=\!plugged --glob=\!autoload --glob=\!temp_dirs --glob=\!myvenv --glob=\!venv --glob=\!node_modules'

" let g:ackprg = 'rg --vimgrep --type-not sql --smart-case --glob=\!.git --glob=\!plugged --glob=\!autoload --glob=\!temp_dirs --glob=\!myvenv --glob=\!venv --glob=\!node_modules'
let g:ack_autoclose = 1
let g:ack_use_cword_for_empty_search = 1

" if executable('rg')
"     set grepprg=rg\ --vimgrep\ --hidden\ --glob\ '!.git'\ --glob\ '!autoload'\ --glob\ '!plugged'\ --glob\ '!temp_dirs'\ --glob\ '!myenv'\ --glob\ '!venv'\ --glob\ '!node_modules'
" endif

if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*" --glob "!myenv" --glob "!venv" --glob "!node_modules"'
  set grepprg=rg\ --vimgrep
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case --hidden '
  \   . '--glob "!.git" --glob "!autoload" --glob "!plugged" --glob "!temp_dirs" '
  \   . '--glob "!myenv" --glob "!venv" --glob "!node_modules" '
  \   . shellescape(<q-args>), 1,
  \   {'options': '--delimiter : --nth 4..'}, <bang>0)
  " " Rg
  " nnoremap <silent> <Leader>fa :Find<CR> 
  " " Rg current worda
  " nnoremap <Leader>fw :Rg <C-R><C-W><space>
endif

cnoreabbrev Ack Ack!
nnoremap <Leader>/ :Ack!<Space>
" nnoremap <Leader>fs :Ack!<Space>

nnoremap <leader>ff :Files<CR> 
" nnoremap <leader>fb :CtrlPBuffer<CR> 

nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>

nnoremap <S-l> :bnext<CR>
nnoremap <S-h> :bprevious<CR>


let g:NERDTreeQuitOnOpen = 0


" Enable Lightline
let g:lightline = {}

let g:lightline.active = {
    \ 'left': [['filename', 'modified', ]],
    \ }

function! LightlineFilename()
    " Get the full path of the current file
    let fullpath = expand('%:p')
    " echom "Full Path: " . fullpath

    " Determine the path separator based on the OS
    let separator = '\'
    if has('unix')
        let separator = '/'
    endif

    " Split the path into components
    let components = split(fullpath, separator)
    " echom "Components: " . string(components)

    " Get the last two components (directories)
    let last_two = components[-3:] 
    " echom "Last Two Components: " . string(last_two)

    " Get the filename
    let filename = fnamemodify(fullpath, ':t')
    " echom "Filename: " . filename

    " Initialize an empty list to hold the formatted components
    let formatted = []

    " Loop through the components and format them
    for i in components[:-4]
        if i != ''
            call add(formatted, strpart(i, 0, 1)) " Take the first letter
        endif
    endfor

    " echom "Formatted Components: " . string(formatted)

    " Combine the formatted components with the last two and the filename
    let formatted_path = join(formatted, '/') . (len(formatted) > 0 ? separator : '') . join(last_two, separator)
    
    " Remove any leading or trailing slashes
    let clean_path = substitute(formatted_path, separator . '\+', separator, 'g')
    " echom "Clean Path: " . clean_path

    " let clean_path = clean_path . (clean_path != '' ? separator : '') . filename
    let clean_path = substitute(clean_path, '\\', '/', 'g')

    return clean_path 

endfunction


let g:lightline.component_function = {
            \ 'filename': 'LightlineFilename'}

colorscheme gruvbox


" ==== ALE ====
let g:ale_lint_on_text_changed = 'always'
let g:ale_fix_on_save = 0
let g:ale_linters = {
            \ 'python': ['pyright'],
            \ 'javascript': [],
            \ 'javascriptreact': [],
            \ 'typescript': [],
            \ 'typescriptreact': [],
            \ 'go': ['gofmt'],
            \ 'yaml': ['yamllint']
            \ }
let g:ale_fixers = {
            \ 'python': ['autopep8'],
            \ 'go': ['gofmt'],
            \ '*': ['remove_trailing_lines', 'trim_whitespace']
            \ }
let g:ale_python_flake8_options = '--ignore=E501,E402,F401,E701,E711,E712'
let g:ale_python_autopep8_options = '--ignore=E501'
let g:ale_yaml_yamllint_options='-d "{extends: relaxed, rules: {line-length: disable}}"'

let g:ale_fixers = {
    \ 'javascript': [],
    \ 'typescript': [],
    \ 'typescriptreact': [],
    \ 'javascriptreact': [],
    \}

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



" Custom command to search using Ripgrep and FZF


nnoremap <Leader>fs :Rg<cr>
nnoremap <Leader>fa :Buffers<cr>

autocmd TextYankPost * if v:event.operator is 'y' | execute 'OSCYankReg "' . v:event.regname . '"' | endif

" noremap <silent> <C-S-l> :vertical resize +5<CR>
" noremap <silent> <C-S-h> :vertical resize -5<CR>
" nnoremap <A-,> :vertical resize -5<CR>
" nnoremap <A-.> :vertical resize +5<CR>

" nnoremap <A-,> <C-w><
" nnoremap <A-.> <C-w>>

" nnoremap <M-,> <C-w><
" nnoremap <M-.> <C-w>>

nnoremap <M-,> <C-w><
nnoremap <M-.> <C-w>>


" nnoremap <silent> <Esc>, :vertical resize +5<CR>
" nnoremap <silent> <Esc>. :vertical resize -5<CR>


" nnoremap <silent> <Esc>, :vertical resize +5<CR>
" nnoremap <silent> <Esc>. :vertical resize -5<CR>
