export ZPLUG_HOME="$HOME/.zplug"

if [ ! -f ~/.zplug/init.zsh ]; then
  echo "install zplug"
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
#  curl -sL --proto-redir -all,https https://zplug.sh/installer | zsh
fi
source ~/.zplug/init.zsh

zplug "zsh-users/zsh-history-substring-search"

zplug "plugins/git",   from:oh-my-zsh, as:plugin
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
#zplug "b4b4r07/enhancd", use:init.sh
#zplug "motemen/ghq", hook-build:"make;make install"

# prompt
zplug "sindresorhus/pure"

# Can manage local plugins
zplug "~/.zsh", from:local, if:"[ -d ~/.zsh ]"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

alias vi='nvim'
alias ls='ls --color'

#export GOROOT=/usr/local/go
export GOPATH="$HOME/workspace/go"
export FZF_DEFAULT_COMMAND='ag -l -g ""' # Use ag as the default source for fzf
#export LANG=en_US.UTF-8
#export GHQ_ROOT='~/workspace/prj'
export PATH=$GOROOT/bin:$GOPATH/bin:$HOME/.local/bin:$PATH

#if zplug check zsh-users/zsh-autosuggestions; then
#    echo "test"
#fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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
#

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]="$terminfo[khome]"
key[End]="$terminfo[kend]"
key[Insert]="$terminfo[kich1]"
key[Backspace]="$terminfo[kbs]"
key[Delete]="$terminfo[kdch1]"
key[Up]="$terminfo[kcuu1]"
key[Down]="$terminfo[kcud1]"
key[Left]="$terminfo[kcub1]"
key[Right]="$terminfo[kcuf1]"
key[PageUp]="$terminfo[kpp]"
key[PageDown]="$terminfo[knp]"

# setup key accordingly
[[ -n "$key[Home]"      ]] && bindkey -- "$key[Home]"      beginning-of-line
[[ -n "$key[End]"       ]] && bindkey -- "$key[End]"       end-of-line
[[ -n "$key[Insert]"    ]] && bindkey -- "$key[Insert]"    overwrite-mode
[[ -n "$key[Backspace]" ]] && bindkey -- "$key[Backspace]" backward-delete-char
[[ -n "$key[Delete]"    ]] && bindkey -- "$key[Delete]"    delete-char
[[ -n "$key[Up]"        ]] && bindkey -- "$key[Up]"        up-line-or-history
[[ -n "$key[Down]"      ]] && bindkey -- "$key[Down]"      down-line-or-history
[[ -n "$key[Left]"      ]] && bindkey -- "$key[Left]"      backward-char
[[ -n "$key[Right]"     ]] && bindkey -- "$key[Right]"     forward-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        echoti smkx
    }
    function zle-line-finish () {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi
