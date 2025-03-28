nmap <leader>lg <cmd>:!lazygit<cr> " Toggle Lazygit
nmap <leader>co <cmd>:only<cr> " close other


" Set font according to system
if has("mac") || has("macunix")
  set gfn=IBM\ Plex\ Mono:h14,Hack:h14,Source\ Code\ Pro:h15,Menlo:h15
elseif has("win16") || has("win32")
  set gfn=IBM\ Plex\ Mono:h14,Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
elseif has("gui_gtk2")
  set gfn=IBM\ Plex\ Mono\ 14,:Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("linux")
  set gfn=IBM\ Plex\ Mono\ 14,:Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("unix")
  set gfn=Monospace\ 11
endif

" Disable scrollbars (real hackers don't use scrollbars for navigation!)
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

" Vim AutoComplete
set complete+=kspell
set completeopt=menuone,longest

" allow specific type file configuration
set modelineexpr

" let g:fzf_vim = {}


" => Turn persistent undo on 
" Set the undodir location
let s:undodir = expand('~/.vimrc_runtime/temp_dirs/undodir')

" Check if the directory exists
if !isdirectory(s:undodir)
  " Create the directory
  call mkdir(s:undodir, "p")
endif

" Set the undofile option
set undodir=s:undodir
set undofile
try
  set undodir=~/.vimrc_runtime/temp_dirs/undodir
  set undofile
catch
endtry

if (exists('g:loaded_lsp_ale') && g:loaded_lsp_ale) || &cp
    finish
endif
let g:loaded_lsp_ale = 1

let g:lsp_ale_diagnostics_severity = get(g:, 'lsp_ale_diagnostics_severity', 'information')
let g:lsp_ale_auto_enable_linter = get(g:, 'lsp_ale_auto_enable_linter', v:true)

if get(g:, 'lsp_ale_auto_config_vim_lsp', v:true)
    " Enable diagnostics and disable all functionalities to show error
    " messages by vim-lsp
    let g:lsp_diagnostics_enabled = 1
    let g:lsp_diagnostics_echo_cursor = 0
    let g:lsp_diagnostics_float_cursor = 0
    let g:lsp_diagnostics_highlights_enabled = 0
    let g:lsp_diagnostics_signs_enabled = 0
    let g:lsp_diagnostics_virtual_text_enabled = 0
endif

" if get(g:, 'lsp_ale_auto_config_ale', v:true)
"     " Disable ALE's LSP integration
"     let g:ale_disable_lsp = 1
" endif

augroup plugin-lsp-ale
    autocmd!
    autocmd User lsp_setup call lsp#ale#enable()
    autocmd User ALEWantResults call lsp#ale#on_ale_want_results(g:ale_want_results_buffer)
augroup END


nmap <leader>xx <cmd>:ALEPopulateQuickfix<cr>
nmap <leader>fx <cmd>:ALEFix<cr>
nmap gd <cmd>:ALEGoToDefinition<cr>


function! CompileCurrentFile()
    let l:current_file = expand('%:p')
    let l:log_file = $USERPROFILE . '\\AppData\\Roaming\\MetaQuotes\\Terminal\\D0E8209F77C8CF37AD8BF550E51FF075\\MQL5\\logbuild.log'
    let l:include_dir = $USERPROFILE . '\\AppData\\Roaming\\MetaQuotes\\Terminal\\D0E8209F77C8CF37AD8BF550E51FF075\\MQL5'
    let l:command = '!"C:\\Program Files\\MetaTrader 5\\metaeditor64.exe" /compile:"' . l:current_file . '" /log:"' . l:log_file . '" /inc:"' . l:include_dir . '"'
    execute l:command
endfunction

" Create a shortcut (e.g., <leader>c) to compile the current file
nnoremap <leader>cp :call CompileCurrentFile()<CR>

