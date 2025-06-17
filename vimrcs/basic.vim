" Sets how many lines of history VIM has to remember
set history=1000

" Don't make vim vi-compatibile
set nocompatible

" Enable filetype plugins
filetype plugin on
filetype indent on

" set for global system
" set clipboard=unnamed,unnamedplus
set clipboard=unnamedplus
" vnoremap \y y:call system("pbcopy", getreg("\""))<CR>
" nnoremap \p :call setreg("\"", system("pbpaste"))<CR>

" Copy the current line to the unnamed register
" nnoremap yy V"+y

" nnoremap p "+p
" nnoremap p "+p


" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * silent! checktime

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = " "

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
" set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set belloff=all
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" Add a bit extra margin to the left
set foldcolumn=1


" Enable syntax highlighting
syntax enable

" Set regular expression engine automatically
set regexpengine=0

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

try
    colorscheme gruvbox
catch
endtry

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile


" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
" vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
" vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


" map <space> /
map <C-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
" https://vi.stackexchange.com/questions/2350/how-to-map-alt-key
" n order to do this I go to console and run sed -n l (you can also use cat for it). Then I press ALT+J and see that the chars on the screen are ^[j .
" I replace ^[ with \e (because that's what is sent by my terminal when I press esc) and the final string for me is \ej.

if has("unix")
    execute "set <M-j>=\ej"
    execute "set <M-h>=\eh"
    execute "set <M-k>=\ek"
    execute "set <M-l>=\el"
endif

nmap <M-j> <C-W>j
nmap <M-k> <C-W>k
nmap <M-h> <C-W>h
nmap <M-l> <C-W>l

" Close the current buffer
map <leader>bd :bd!<cr>

" QUIT all
nnoremap <Leader>bk :q!<CR>


" Close all the buffers
map <leader>ba :bufdo bd<cr>

" nnoremap jk <Esc>
inoremap jk <Esc>

" map <leader>pl :bnext<cr>
" map <leader>ph :bprevious<cr>

" Useful mappings for managing tabs
map <C-l> :tabnext<cr>
map <C-h> :tabprevious<cr>

" map <leader>tn :tabnew<cr>
" map <leader>to :tabonly<cr>
" map <leader>tc :tabclose<cr>
" map <leader>tm :tabmove
" map <leader>t<leader> :tabnext<cr>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" Always show the status line
" highlight VertSplit guibg=#181818 guifg=#996228
highlight SLBackground guibg=#181818 guifg=#996228
highlight SLFileType guibg=indianred guifg=#663333
highlight SLBufNumber guibg=SeaGreen guifg=#003333
highlight SLLineNumber guibg=#80a0ff guifg=#003366

" disable line this for 
set statusline=



" Remap VIM 0 to first non-blank character
map 0 ^



" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun


if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif



" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
" map <leader>sa zg
map <leader>sa :wa<cr>
map <leader>nh :nohl<cr>
" map <leader>s? z=


" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
" map <leader>x :e ~/buffer.md<cr>

" Highlight Yank 
let g:highlightedyank_highlight_duration = 150


" set termguicolors
set termguicolors


" set cursor bold when normal, thin and hightlight when edit
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" always show Status
set laststatus=2
set timeoutlen=300

" autocmd VimLeave * call system("echo -n '" . escape(getreg('""'), "'") . "' | xclip -selection clipboard")
" " Yank into all these at once:
" "     vim y/p register
" "     wayland primary
" "     wayland clipboard


" if exists('$WAYLAND_DISPLAY')
"   " Yank to wl-copy on any yank (normal or visual)
"   autocmd TextYankPost * call SetClipboard(v:event.regcontents)

"   function! SetClipboard(lines)
"     let cliptext = join(a:lines, "\n")
"     let @* = cliptext
"     let @+ = cliptext
"     call system('wl-copy', cliptext)
"   endfunction


"   " Paste from wl-paste using `p` or `P`
"   nnoremap <silent> p :let @" = system('wl-paste -p') \| normal! p<CR>
"   " nnoremap <silent> P :let @" = system('wl-paste -p') \| normal! P<CR>
" endif



" nnoremap <silent> <leader>p :call system("xclip -selection clipboard -o")<cr>









