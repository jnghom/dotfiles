if [ $TILIX_ID ] || [ $VTE_VERSION ] ; then source /etc/profile.d/vte.sh; fi
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

bindkey -e

[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"
[ -f "$HOME/.bind-key.zsh" ] && source "$HOME/.bind-key.zsh"

### Added by Zinit's installer
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"
#source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk
zinit ice wait'!0'
zinit light junegunn/fzf-bin
zinit ice wait'!0'
zinit light zsh-users/zsh-history-substring-search
zinit ice wait'!0'
zinit light zsh-users/zsh-syntax-highlighting
zinit ice wait'!0'
zinit light zsh-users/zsh-completions
zinit ice wait'!0'
zinit light zsh-users/zsh-autosuggestions
zinit ice wait'!3'
zinit snippet OMZ::plugins/extract/extract.plugin.zsh
zinit ice wait'!1'
zinit snippet OMZ::plugins/command-not-found/command-not-found.plugin.zsh
zinit ice wait'!1'
zinit light chrissicool/zsh-256color
# zinit ice wait'!1'
zinit light mafredri/zsh-async
zinit ice wait'!2'
zinit light supercrabtree/k
zinit ice wait'!2'
# zinit light marzocchi/zsh-notify
zinit ice wait'!2'
# zinit ice wait'!1'
# zinit light junegunn/fzf/shell/key-bindings.zsh
zinit snippet https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh
# zinit light plugins/shrink-path, from:oh-my-zsh, as:plugin
# zinit light b4b4r07/enhancd, use:init.sh
zinit ice wait'!2'
zinit light urbainvaes/fzf-marks
# zinit ice wait'!1' atload"setupsolarized dircolors.256dark"
zinit ice wait'!0'
zinit light joel-porquet/zsh-dircolors-solarized

zinit ice as"completion"
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker


# zinit ice wait'!1'
# zinit light denysdovhan/spaceship-prompt
#
# zinit pack for pyenv

# Load starship theme
# zinit ice as"command" from"gh-r" \
#           atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
#           atpull"%atclone" src"init.zsh"
# zinit light starship/starship

# zplug "zsh-users/zsh-history-substring-search"
# zplug "zsh-users/zsh-syntax-highlighting"
# zplug "zsh-users/zsh-completions"
# zplug "zsh-users/zsh-autosuggestions"
# zplug "plugins/command-not-found", from:oh-my-zsh
# zplug "plugins/history", from:oh-my-zsh, as:plugin
# zplug "plugins/extract", from:oh-my-zsh
# zplug "zsh-users/zsh-syntax-highlighting"
# zplug "chrissicool/zsh-256color"
# zplug "mafredri/zsh-async"
# zplug "supercrabtree/k"
# zplug "marzocchi/zsh-notify"
# zplug "junegunn/fzf", use:shell/key-bindings.zsh
# zplug "plugins/shrink-path", from:oh-my-zsh, as:plugin
# zplug "b4b4r07/enhancd", use:init.sh
# zplug "urbainvaes/fzf-marks"
# zplug 'zplug/zplug', hook-build:'zplug --self-manage'
export ENHANCD_COMMAND=c

# POWERLEVEL9K_DIR_HOME_FOREGROUND=184
# POWERLEVEL9K_TIME_FOREGROUND='184'
# zinit ice depth=1; zinit light romkatv/powerlevel10k


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

alias grep='grep --color'
alias ls='ls --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias vim='nvim'
alias gs='git status'

[ -f $HOME/.agignore ] && alias ag='ag --path-to-ignore ~/.agignore'
[ -f $HOME/.rgignore ] && alias rg='rg --ignore-file $HOME/.rgignore'

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

# Switch tmux-sessions
fs() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf-tmux --query="$1" --select-1 --exit-0) &&
  tmux switch-client -t "$session"
}

fzf-down() {
  fzf --height 50% "$@" --border
}

fzf-full() {
  fzf "$@" --border
}

gf() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

# gb() {
#   is_in_git_repo || return
#   git branch -a --color=always | grep -v '/HEAD\s' | sort |
#   fzf-down --ansi --multi --tac --preview-window right:70% \
#     --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
#   sed 's/^..//' | cut -d' ' -f1 |
#   sed 's#^remotes/##'
# }

gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {} | head -'$LINES
}

ghh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-full --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
  grep -o "[a-f0-9]\{7,\}"
}

gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-down --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
  cut -d$'\t' -f1
}

cf() {
  local file

  # file="$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1)"
  file="$(locate -Ai -0 / | grep -z -vE '~$' | fzf --read0 -0 -1)"

  if [[ -n $file ]]
  then
     if [[ -d $file ]]
     then
        cd -- $file
     else
        cd -- ${file:h}
     fi
  fi

}

# vf - fuzzy open with vim from anywhere
# ex: vf word1 word2 ... (even part of a file name)
# zsh autoload function
vf() {
  local files

  files=(${(f)"$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1 -m)"})

  if [[ -n $files ]]
  then
     vim -- $files
     print -l $files[1]
  fi
}

# fuzzy grep open via ag
vg() {
  local file

  file="$(rg --nobreak --noheading $@ | fzf -0 -1 | awk -F: '{print $1 " +" $2}')"

  if [[ -n $file ]]
  then
     vim $file
  fi
}

# fd - cd to selected directory
fdd() {
  DIR=`find ${1:-*} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf-tmux` \
    && cd "$DIR"
}

# fda - including hidden directories
fda() {
  DIR=`find ${1:-.} -type d 2> /dev/null | fzf-tmux` && cd "$DIR"
}

# Figlet font selector
fgl() (
  cd /usr/local/Cellar/figlet/*/share/figlet/fonts
  ls *.flf | sort | fzf --no-multi --reverse --preview "figlet -f {} Hello World!"
)

# fbr - checkout git branch
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fco - checkout git branch/tag
fco() {
  local tags branches target
  tags=$(
    git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$tags"; echo "$branches") |
    fzf-tmux -l40 -- --no-hscroll --ansi +m -d "\t" -n 2 -1 -q "$*") || return
  git checkout $(echo "$target" | awk '{print $2}')
}

# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --header "Press CTRL-S to toggle sort" \
      --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
                 xargs -I % sh -c 'git show --color=always % | head -200 '" \
      --bind "enter:execute:echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
              xargs -I % sh -c 'vim fugitive://\$(git rev-parse --show-toplevel)/.git//% < /dev/tty'"
}


# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local file
  file=$(fzf-tmux --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && ${EDITOR:-vim} "$file"
}

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
  local out file key
  IFS=$'\n' out=($(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e))
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}

if [ -n "$TMUX_PANE" ]; then
  fzf_tmux_helper() {
    local sz=$1;  shift
    local cmd=$1; shift
    tmux split-window $sz \
      "bash -c \"\$(tmux send-keys -t $TMUX_PANE \"\$(source ~/.fzf.bash; $cmd)\" $*)\""
  }

  # https://github.com/wellle/tmux-complete.vim
  fzf_tmux_words() {
    fzf_tmux_helper \
      '-p 40' \
      'tmuxwords.rb --all --scroll 500 --min 5 | fzf --multi | paste -sd" " -'
  }

  # ftpane - switch pane (@george-b)
  ftpane() {
    local panes current_window current_pane target target_window target_pane
    panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
    current_pane=$(tmux display-message -p '#I:#P')
    current_window=$(tmux display-message -p '#I')

    target=$(echo "$panes" | grep -v "$current_pane" | fzf +m --reverse) || return

    target_window=$(echo $target | awk 'BEGIN{FS=":|-"} {print$1}')
    target_pane=$(echo $target | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)

    if [[ $current_window -eq $target_window ]]; then
      tmux select-pane -t ${target_window}.${target_pane}
    else
      tmux select-pane -t ${target_window}.${target_pane} &&
      tmux select-window -t $target_window
    fi
  }

  # Bind CTRL-X-CTRL-T to tmuxwords.sh
  # bind '"\C-x\C-t": "$(fzf_tmux_words)\e\C-e"'
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


export PIPENV_IGNORE_VIRTUALENVS=1

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[[ -f ~/.pyenv/versions/dev/bin/aws_zsh_completer.sh ]] && source ~/.pyenv/versions/dev/bin/aws_zsh_completer.sh
### End of Zinit's installer chunk
#

echo zshrc pyenv $PYENV_ROOT
if [ -x "$HOME/.pyenv/bin/pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  # eval "$(pyenv init -)"
  # eval "$(pyenv virtualenv-init -)"
fi


if [ -d "$HOME/.cargo" ]; then
  export CARGO_BIN="$HOME/.cargo/bin"
  export PATH="$CARGO_BIN:$PATH"
fi

if type yarn &> /dev/null ; then
  export YARN_BIN="$HOME/.yarn/bin"
  export PATH="$YARN_BIN:$PATH"
fi

if [ -d "$HOME/usr/bin" ]; then
  export USER_BIN="$HOME/usr/bin"
  export PATH=$USER_BIN:$PATH
fi

export PATH=$HOME/.local/bin:$PATH

if [ -d "/usr/local/go/bin" ]; then
  export GOROOT=/usr/local/go
  export GOPATH=$HOME/go
  export PATH=$GOPATH/bin:$PATH:$GOROOT/bin
fi

if type hub &> /dev/null ; then
  eval "$(hub alias -s)"
fi

if [ -f $HOME/.rsyncignore ]; then
  alias rsynci="rsync --exclude-from $HOME/.rsyncignore"
fi

autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

export PATH=$HOME/.poetry/bin:$PATH

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# tabtab source for packages
# uninstall by removing these lines
# [ -f ~/.config/tabtab/__tabtab.bash ] && . ~/.config/tabtab/__tabtab.bash || true

export PATH=$PATH:$HOME/.pulumi/bin
export PATH=$PATH:$HOME/usr/flutter/bin


[[ -f /usr/local/bin/aws_completer ]] && complete -C '/usr/local/bin/aws_completer' aws

if command -v nvim > /dev/null ; then
  export EDITOR=nvim
  export VISUAL=nvim
  alias vim="nvim"
elif command -v vim > /dev/null ; then
  export EDITOR=vim
  export VISUAL=vim
fi

alias kssh="kitty +kitten ssh"

eval "$(starship init zsh)"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

command -v zoxide > /dev/null && eval "$(zoxide init zsh)"

if type lazygit &> /dev/null ; then
  alias lg="lazygit"
fi
