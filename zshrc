export ZPLUG_HOME="$HOME/.zplug"

[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"
[ -f "$HOME/.bind-key.zsh" ] && source "$HOME/.bind-key.zsh"

if [ ! -f ~/.zplug/init.zsh ]; then
  echo "install zplug"
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi
source ~/.zplug/init.zsh

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
zplug "junegunn/fzf", use:shell/key-bindings.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "plugins/shrink-path", from:oh-my-zsh, as:plugin
zplug "b4b4r07/enhancd", use:init.sh
zplug "urbainvaes/fzf-marks"
export ENHANCD_COMMAND=c

# zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme
# zplug "sindresorhus/pure"

# zplug "geometry-zsh/geometry", hook-load:my_geometry_init
# my_geometry_init() {
#   GEOMETRY_COLOR_DIR=142
# }

# zplug "mgee/slimline", hook-load:my_slimline_init
# my_slimline_init() {
#   export SLIMLINE_CWD_COLOR='yellow'
# #   export SLIMLINE_PROMPT_SYMBOL='>'
# }

# zplug "yardnsm/blox-zsh-theme", hook-load:my_blox_zsh_theme_init
# my_blox_zsh_theme_init() {
#   export BLOX_BLOCK__SYMBOL_SYMBOL='>'
# }

function my_prompt_dir {
  echo -n %{$fg[yellow]%}
  echo -n $(pwd | sed -e "s,^$HOME,~,")
  echo -n %{$reset_color%}
}

# PROMPT="%{$fg[yellow]%}$(my_prompt_dir)%{$reset_color%}"
# PROMPT="$(my_prompt_dir)"

zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme, hook-load:my_spaceship_prompt_init
my_spaceship_prompt_init() {
  SPACESHIP_PROMPT_ADD_NEWLINE=false
  SPACESHIP_CHAR_SYMBOL='>'
  SPACESHIP_CHAR_SUFFIX=' '
  SPACESHIP_USER_SHOW='needed'
  SPACESHIP_HOST_SHOW=true
  SPACESHIP_DIR_COLOR=142
  SPACESHIP_DIR_PREFIX=''
  SPACESHIP_HOST_COLOR=064
  SPACESHIP_HOST_COLOR_SSH=064

  SPACESHIP_PROMPT_ORDER=(
    user
    host
    dir
    char
  )
  SPACESHIP_RPROMPT_ORDER=(
    exec_time
    time
    git
    pyenv
    jobs
    exit_code
  )
  export SPACESHIP_PYENV_SHOW=true
  export SPACESHIP_PYENV_SYMBOL=''
  SPACESHIP_PYENV_PREFIX='🐍 '
  SPACESHIP_PYENV_SUFFIX=' '
  SPACESHIP_PYENV_COLOR='green'

  SPACESHIP_GIT_BRANCH_SHOW=true
  SPACESHIP_GIT_STATUS_SHOW=true
  SPACESHIP_GIT_PREFIX=''
  SPACESHIP_GIT_SUFFIX=' '
  SPACESHIP_PROMPT_DEFAULT_PREFIX='. '
}

# Can manage local plugins
zplug "~/.zsh", from:local, if:"[ -d ~/.zsh ]"

[ -f $HOME/.colors/dircolors.256dark ] && eval `dircolors $HOME/.colors/dircolors.256dark`

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

# setopt share_history

## Command history configuration
if [ -z "$HISTFILE" ]; then
    HISTFILE=$HOME/.zsh_history
fi

HISTSIZE=10000000
SAVEHIST=10000000

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
alias vi='nvim'
export EDITOR=nvim
export VISUAL=nvim

export USER_BIN="$HOME/usr/bin"
export PATH=$USER_BIN:$PATH

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

gb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-down --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {} | head -'$LINES
}

gh() {
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

  file="$(ag --nobreak --noheading $@ | fzf -0 -1 | awk -F: '{print $1 " +" $2}')"

  if [[ -n $file ]]
  then
     vim $file
  fi
}

# fd - cd to selected directory
fd() {
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

# ftags - search ctags
ftags() {
  local line
  [ -e tags ] &&
  line=$(
    awk 'BEGIN { FS="\t" } !/^!/ {print toupper($4)"\t"$1"\t"$2"\t"$3}' tags |
    cut -c1-$COLUMNS | fzf --nth=2 --tiebreak=begin
  ) && $EDITOR $(cut -f3 <<< "$line") -c "set nocst" \
                                      -c "silent tag $(cut -f2 <<< "$line")"
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
