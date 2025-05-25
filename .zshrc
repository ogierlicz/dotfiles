# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Oh-my-zsh setup  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~~~

# vim
export VISUAL=nvim
export EDITOR=nvim

# fzf
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden'
export FZF_COLORS='--color="border:bright-black,separator:bright-black,fg:white,bg:-1,hl:green,fg+:white,bg+:-1,gutter:-1,hl+:bright-red,query:yellow,disabled:black,info:blue,prompt:cyan,pointer:bright-yellow,marker:bright-cyan,spinner:magenta,header:bright-green"'
export FZF_DEFAULT_OPTS="--border=rounded --layout=reverse --no-multi --select-1 --exit-0 --pointer='> ' --marker='+ ' --prompt ' ' --cycle $FZF_COLORS"
export FZF_TMUX_OPTS="-p 70%"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Aliases  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# editors
alias v=nvim
alias vi=nvim

# ls enhacements
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -lathr'

# finds all files recursively and sorts by last modification, ignore hidden files
alias lastmod='find . -type f -not -path "*/\.*" -exec ls -lts {} +'

# git
alias lg='lazygit'

# tmux
alias t='tmux'

# ~~~~~~~~~~~~~~~~~~~~~~ Scripts ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# script for connecting via ssh to multiple hosts in /etc/hosts that automatically splits screen with tmux 
function s() {
local ssh_hosts=$(grep -v '^#' /etc/hosts | grep -v '^\s*$' | awk '{if ($1 != "IP" && NF >= 2) print $2}' | fzf --multi --query="$*" --history="$HOME/.fzf/history/s")

if [[ -n "$ssh_hosts" ]]; then
  local hosts=("${(f)ssh_hosts}")
  
  if [[ ${#hosts[@]} -gt 1 ]]; then
    tmux new-window "ssh ${hosts[1]}"
    
    hosts=("${(@)hosts[2,-1]}")
    
    for host in "${hosts[@]}"; do
      tmux split-window "ssh $host"
      tmux select-layout tiled > /dev/null
    done
    
    tmux select-pane -t 1
    sleep 2
    tmux select-layout tiled > /dev/null
  else
    ssh $ssh_hosts
  fi
fi
}
