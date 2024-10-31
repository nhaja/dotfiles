eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

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

rosenv() {
    local env_name="ros2"
    local active_env=$(conda info | grep "active environment" | awk '{print $4}')

    if [[ "$active_env" == "$env_name" ]]; then
      mamba deactivate
    else
      mamba activate ros2

      export ROS_DOMAIN_ID=68
      export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

      source ~/ros/iac_ws/install/setup.zsh

      # export CYCLONDEDDS_URI=/Users/nhaja/.ros_config/cyclonedds.xml

      # export Python_EXECUTABLE=${CONDA_PREFIX}/bin/python
      # export Python3_EXECUTABLE=${CONDA_PREFIX}/bin/python
      # export PYTHON_EXECUTABLE=${CONDA_PREFIX}/bin/python
      # export Python_FIND_STRATEGY=LOCATION
      # export Python3_FIND_STRATEGY=LOCATION
    fi
}

if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux attach-session -t default || tmux new-session -s default
fi

alias vi=nvim

#tmux-window-name() {
#	($TMUX_PLUGIN_MANAGER_PATH/tmux-window-name/scripts/rename_session_windows.py &)
#}
# add-zsh-hook chpwd tmux-window-name

export NIX_CONF_DIR=/Users/nhaja/dotfiles/nix
