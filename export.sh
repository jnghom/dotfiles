
#export GOROOT=/usr/local/go
export GOPATH="$HOME/workspace/go"
export FZF_DEFAULT_COMMAND='ag -l -g ""' # Use ag as the default source for fzf
export PATH=$GOROOT/bin:$GOPATH/bin:$HOME/.local/bin:$PATH

command -v nvim > /dev/null && export EDITOR=nvim
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden --bind '?:toggle-preview'"

