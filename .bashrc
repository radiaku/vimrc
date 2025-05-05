# ln -s ~/.vimrc_runtime/.bashrc ~/.bashrc
# or
# mv ~/.vimrc_runtime/.bashrc ~/.bashrc
# cp ~/.vimrc_runtime/.bashrc ~/.bashrc
#
# sudo ln --symbolic $(which fdfind) /usr/local/bin/fd
# sudo ln --symbolic $(which fd-find) /usr/local/bin/fd
#
# /ubuntu
# sudo apt install git fzf zoxide ripgrep fd-find tree untar tar p7zip-full
# sudo ln --symbolic $(which fdfind) /usr/local/bin/fd
#
# /centos
# sudo yum install epel-release
# sudo yum install git fzf zoxide ripgrep tree untar tar p7zip p7zip-plugins
#
# install fd without rust https://github.com/sharkdp/fd/releases
# download musl linked binary package, e.g. fd-v7.3.0-x86_64-unknown-linux-musl.tar.gz
# untar it
#
# cp ./fd /usr/local/bin/
# cp ./fd.1 /usr/local/share/man/man1/
#

# export TERM='xterm-256color'
export TERM="xterm-256color"
export EDITOR='vim'
export VISUAL='vim'

alias nv='nvim'
alias v='vim'
alias py3='python3'

HISTSIZE=10000
HISTFILESIZE=200000
HISTCONTROL=ignoreboth
shopt -s histappend
shopt -s checkwinsize

# Function to sanitize session names
sanitize_session_name() {
  local trimmed="$(echo -n "$1" | xargs)"
  local cleaned="$(echo -n "$trimmed" | tr -c '[:alnum:]_.-' '_')"
  echo "${cleaned%"_"}"
}

# Function to manage tmux sessions
manage_tmux_session() {
  exec </dev/tty
  exec <&1

  if [ -z "$TMUX" ]; then
    if tmux ls | grep -q "^$1:"; then
      tmux attach -t "$1"
    else
      tmux new-session -ds "$1"
      tmux send-keys -t "$1" "cd $2" C-m 
      tmux attach -t "$1" 
    fi
  else
    if tmux ls | grep -q "^$1:"; then
      tmux switch-client -t "$1"
    else
      tmux new-session -ds "$1"
      tmux send-keys -t "$1" "cd $2" C-m 
      tmux switch-client -t "$1"
    fi
  fi
}

# Remove any existing alias
unalias fzf-cd 2>/dev/null

# Function to change directories using fzf and manage tmux sessions
fzf-cd() {
  local fd_options fzf_options target

  fd_options=(
    --type directory
    --max-depth 2
    --exclude .git
    --exclude node_modules
  )

  fzf_options=(
    --preview='tree -L 1 {}'
    --bind=ctrl-space:toggle-preview
    --exit-0
  )

  target="$(fd . ~/Dev "${fd_options[@]}" | fzf "${fzf_options[@]}")"

  # Check if the Escape key was pressed (target will be empty)
  if [[ -z "$target" ]]; then
    return 0  # Do nothing if Escape was pressed
  fi

  test -f "$target" && target="${target%/*}"

  parent_dir="$(basename "$(dirname "$target")")"
  prefix="${parent_dir:0:1}"  # First letter
  basename="$(basename "$target")"
  session_name="fzf-${prefix}_${basename}"
  session_name="$(sanitize_session_name "$session_name")"

  manage_tmux_session "$session_name" "$target" || {
    echo "Failed to create or attach to tmux session."
    return 1
  }
}


# Bind Ctrl+F to execute fzf-cd
bind -x '"\C-f": fzf-cd'

function jump_to_tmux_session() {
  if [ -z "$TMUX" ]; then
    local selected_session
    selected_session=$(tmux list-sessions -F '#{session_name}' | \
      sort -r | \
      fzf --reverse --header "Jump to session" \
          --preview 'tmux capture-pane -t {} -p | head -20' \
          --bind 'ctrl-d:execute-silent(tmux kill-session -t {})+reload(tmux list-sessions -F "#{session_name}" | sort -r)')

    if [ -n "$selected_session" ]; then
      manage_tmux_session "$selected_session" || {
        echo "Failed to attach to tmux session."
        return 1
      }
    else
      echo "No session selected."
    fi
  else
    tmux list-sessions -F '#{session_name}' | \
      sort -r | \
      fzf --reverse --header "Jump to session" \
          --preview 'tmux capture-pane -pt {} | head -20' \
          --bind 'ctrl-d:execute-silent(tmux kill-session -t {})+reload(tmux list-sessions -F "#{session_name}" | sort -r)' | \
      xargs -r tmux switch-client -t
  fi
}


# Bind Alt+l to the function
bind -x '"\C-L": jump_to_tmux_session'



# ff() {
#     aerospace list-windows --all | fzf --bind 'enter:execute(bash -c "aerospace focus --window-id {1}")+abort'
# }
# bind -x '"\C-A": ff'

# Function to enter alternate screen mode and clear the screen
ias() {
    echo -e "\033[?1049h"
    clear
    printf '\e[3J'
}

# Function to exit alternate screen mode, clear the screen, and attempt to clear the scrollback buffer
cas() {
    echo -e "\033[?1049l"
    clear
    printf '\e[3J'
}


export PATH=~/.local/bin/:$PATH
export PATH=~/local/bin/:$PATH
# eval "$(rbenv init - --no-rehash zsh)"

export PATH=$PATH:$HOME/go/bin
eval "$(zoxide init bash)"

# Load system-wide bash completion
if [ -f /etc/profile.d/bash_completion.sh ]; then
    source /etc/profile.d/bash_completion.sh
fi

# Enable history search with up/down arrows (only if commented out above)
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Load fzf keybindings (for fuzzy history search with Ctrl+R, Ctrl+T, etc.)
if [ -f $HOME/.fzf-keybinding.bash ]; then
    source $HOME/.fzf-keybinding.bash
fi




