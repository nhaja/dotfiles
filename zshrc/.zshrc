if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux attach-session -t default || tmux new-session -s default
fi

# eval "$(zellij setup --generate-auto-start zsh)"

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# eval "$(starship init zsh)"
# export STARSHIP_CONFIG=~/.config/starship/starship.toml

export CPATH=/opt/homebrew/include
export LIBRARY_PATH=/opt/homebrew/lib

function matlab() {
    /Applications/MATLAB_R2024b.app/bin/matlab $#
}

export NVM_DIR="$HOME/.nvm"
    [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
    [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export CMAKE_C_COMPILER="/opt/homebrew/opt/llvm/bin/clang"
export CMAKE_CXX_COMPILER="/opt/homebrew/opt/llvm/bin/clang++"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/nhaja/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/nhaja/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/nhaja/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/nhaja/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/Users/nhaja/anaconda3/etc/profile.d/mamba.sh" ]; then
  . "/Users/nhaja/anaconda3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<


source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

rosenv_tam() {
    echo "Activating ROS2 environment ..."
    local env_name="ros2_tam"
    local active_env=$(conda info | grep "active environment" | awk '{print $4}')

    if [[ "$active_env" == "$env_name" ]]; then
        echo "Environment $env_name is already active, deactivating ..."
      mamba deactivate
    else
        echo "Activating environment $env_name ..."
      mamba activate $env_name

      export ROS_DOMAIN_ID=68
      export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
    fi
}

rosenv_ssa() {
    echo "Activating ROS2 environment ..."
    local env_name="ros1_ssa"
    local active_env=$(conda info | grep "active environment" | awk '{print $4}')

    if [[ "$active_env" == "$env_name" ]]; then
        echo "Environment $env_name is already active, deactivating ..."
      mamba deactivate
    else
        echo "Activating environment $env_name ..."
      mamba activate $env_name

      source ~/ros/ssa_ws/install/setup.zsh
    fi
}
docker_tam() {
    echo "Activating TAM Docker context ..."
    local lima_vm_name="ros2_tam"
    local lima_docker_context="lima-$lima_vm_name"
    local docker_context=$(docker context ls --format '{{.Name}}' | grep "$lima_docker_context")
    local lima_vm_status=$(limactl list | grep "$lima_vm_name" | awk '{print $2}')
    if [[ "$lima_vm_status" == "Stopped" ]]; then
        echo "Starting Lima VM $lima_vm_name ..."
      limactl start $lima_vm_name
    fi
        
    if [[ -z "$docker_context" ]]; then
        echo "Creating Docker context for Lima VM $lima_vm_name ..."
      docker context create lima-${lima_vm_name} --docker "host=unix:///Users/nhaja/.lima/$lima_vm_name/sock/docker.sock"
    fi
    docker context use lima-${lima_vm_name}
}


source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NIX_CONF_DIR=/Users/nhaja/dotfiles/nix

if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
    . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

export PATH=/opt/homebrew/Cellar/qemu/9.1.2/bin:$PATH

export EDITOR=nvim

alias vi=nvim
alias "cat=bat"

alias ls="eza --icons --git"
alias ll="eza -l --icons --git -a"
alias lt="eza --tree --level=2 --long --icons --git"

eval "$(fzf --zsh)"

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'
export FZF_DEFAULT_OPTS='--height 50% --layout=reverse --border --color=hl:#d7005f --preview-window=down'
export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}'"
export FZF_TMUX_OPTS=' -p90%,70%'
# Lima BEGIN
# Make sure iptables and mount.fuse3 are available
PATH="$PATH:/usr/sbin:/sbin"
export PATH
# Lima END
