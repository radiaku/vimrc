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

# History size
HISTSIZE=10000
HISTFILESIZE=200000

# Ignore duplicate and space-prefixed commands
HISTCONTROL=ignoreboth

# Add timestamps to history
export HISTTIMEFORMAT="%F %T "

# Append to history file after each command
shopt -s histappend

# Write to history file after every command
PROMPT_COMMAND="history -a"


# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\n\$ '
fi
unset color_prompt force_color_prompt

# Function to sanitize session names
sanitize_session_name() {
  local input="$1"
  # Trim leading/trailing whitespace using parameter expansion
  input="${input#"${input%%[![:space:]]*}"}"
  input="${input%"${input##*[![:space:]]}"}"
  # Replace non-alphanumeric with _
  local cleaned
  cleaned="$(echo -n "$input" | tr -c '[:alnum:]' '_')"
  # Remove trailing underscore if present
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
    --max-depth 1
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
      xargs -r0 tmux switch-client -t
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

export PATH=$PATH:/usr/local/go/bin
export PATH="$HOME/miniconda3/bin:$PATH"
source "$HOME/miniconda3/etc/profile.d/conda.sh"

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
if [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
    source /usr/share/doc/fzf/examples/key-bindings.bash
else
    source "$HOME/.fzf-keybinding.bash"
fi

__fzf_history_search() {
    local query="${READLINE_LINE}"
    local selected
    selected=$(history | fzf --tac +s --tiebreak=index --ansi --no-sort --reverse \
        --prompt='History> ' --query="$query" | sed 's/ *[0-9]* *//')
    if [ -n "$selected" ]; then
        READLINE_LINE="$selected"
        READLINE_POINT=${#READLINE_LINE}
    fi
}

bind -x '"\C-r": __fzf_history_search'

# Ensure only one ssh-agent is running and set the correct environment variables
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    eval "$(ssh-agent -s)" > /dev/null
    # eval $(keychain --eval --quiet --agents ssh id_ed25519_global)
    # eval $(keychain --eval --agents ssh id_ed25519_global) > /dev/null
else
    # Check if ssh-agent is running and set SSH_AUTH_SOCK
    if pgrep -u "$USER" ssh-agent > /dev/null; then
        # export SSH_AUTH_SOCK=$(find /tmp/ssh-* -name "agent.*" -exec echo {} \; | head -n 1)
        export SSH_AUTH_SOCK=$(find /tmp/ssh-* -name "agent.*" -print -quit)
        export SSH_AGENT_PID=$(pgrep -u "$USER" -a ssh-agent | awk '{print $1}' | head -n 1)
    fi
    if ! ssh-add -l > /dev/null 2>&1; then
        ssh-add "$HOME/.ssh/id_ed25519_global" > /dev/null
    fi
fi

# Export variables for future sessions
export SSH_AUTH_SOCK
export SSH_AGENT_PID




