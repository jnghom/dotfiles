export ZPLUG_HOME="$HOME/.zplug"

[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"
[ -f "$HOME/.bind-key.zsh" ] && source "$HOME/.bind-key.zsh"

if [ ! -f ~/.zplug/init.zsh ]; then
  echo "install zplug"
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
#  curl -sL --proto-redir -all,https https://zplug.sh/installer | zsh
fi
source ~/.zplug/init.zsh

zplug "zsh-users/zsh-history-substring-search"

#zplug "plugins/git",   from:oh-my-zsh, as:plugin
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "plugins/history", from:oh-my-zsh, as:plugin
zplug "zsh-users/zsh-syntax-highlighting"
zplug "chrissicool/zsh-256color"
zplug "mafredri/zsh-async"
zplug "supercrabtree/k"
zplug "marzocchi/zsh-notify"
zplug "clvv/fasd", as:command
#zplug "mollifier/anyframe"
zplug "junegunn/fzf", use:shell/key-bindings.zsh
zplug "joel-porquet/zsh-dircolors-solarized"
#zplug "b4b4r07/enhancd", use:init.sh
#zplug "motemen/ghq", hook-build:"make;make install"
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# prompt
# zplug "sindresorhus/pure"
zplug "mgee/slimline"
export SLIMLINE_CWD_COLOR='yellow'
export SLIMLINE_PROMPT_SYMBOL='>'

# Can manage local plugins
zplug "~/.zsh", from:local, if:"[ -d ~/.zsh ]"

# Install plugins if there are plugins that have not been installed
if ! zplug check; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

mkcscope() {
    rm -rf cscope.files cscope.files
    find . \( -name '*.c' -o -name '*.cpp' -o -name '*.cc' -o -name '*.h' \) -print > cscope.files
    cscope -i cscope.files
}

# setopt inc_append_history
# setopt share_history

## Command history configuration
if [ -z "$HISTFILE" ]; then
    HISTFILE=$HOME/.zsh_history
fi

HISTSIZE=10000
SAVEHIST=10000

# Show history
case $HIST_STAMPS in
  "mm/dd/yyyy") alias history='fc -fl 1' ;;
  "dd.mm.yyyy") alias history='fc -El 1' ;;
  "yyyy-mm-dd") alias history='fc -il 1' ;;
  *) alias history='fc -l 1' ;;
esac

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
# setopt share_history # share command history data

# eval `dircolors ~/.dir_colors/dircolors.256dark`
source ~/.zsh/zsh-dircolors-solarized/zsh-dircolors-solarized.zsh
alias grep='grep --color'
alias ls='ls --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias vi='nvim'
export EDITOR=nvim
export VISUAL=nvim

# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# if command -v pyenv 1>/dev/null 2>&1; then
#   eval "$(pyenv init -)"
# fi
# eval "$(pyenv virtualenv-init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
