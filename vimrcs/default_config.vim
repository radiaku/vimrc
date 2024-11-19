let data_dir = expand('~/.vimrc_runtime')

if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo ' . data_dir . '/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  " Use the correct command to ensure the plugin manager is loaded
  autocmd VimEnter * call plug#begin() | PlugInstall --sync | call plug#end() | source $MYVIMRC
endif
