![VIM](https://dnp4pehkvoo6n.cloudfront.net/43c5af597bd5c1a64eb1829f011c208f/as/Ultimate%20Vimrc.svg)

This my Custom vimrc for own customization, Lightweight version for my server, where sometimes neovim not supported.

thanks for [amix](https://github.com/amix/vimrc) 

# INSTALL

```
git clone https://github.com/radiaku/vimrc ~/.vimrc_runtime
```

then 

```

cd ~/.vimrc_runtime

# Create or overwrite the ~/.vimrc file
cat << 'EOF' > ~/.vimrc
" DO NOT EDIT THIS FILE
" Add your own customizations in ~/.vimrc_runtime/my_configs.vim

set runtimepath+=~/.vimrc_runtime

let data_dir = expand('~/.vimrc_runtime')

source ~/.vimrc_runtime/vimrcs/default_config.vim

if !empty(glob(data_dir . '/plugged/*'))
  source ~/.vimrc_runtime/vimrcs/basic.vim
  source ~/.vimrc_runtime/vimrcs/extended.vim
  source ~/.vimrc_runtime/vimrcs/plugin_config.vim
endif
EOF
```

then open vim

```
:PlugInstall
```

wait until done and then: 

```
:source ~/.vimrc
```

done


