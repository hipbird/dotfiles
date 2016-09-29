 # Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Display Zsh version and display number
printf "\n$fg_bold[cyan]This is ZSH $fg_bold[red]${ZSH_VERSION}"
printf "$fg_bold[cyan] - DISPLAY on $fg_bold[red]$DISPLAY$reset_color\n\n"

setopt no_flow_control

# Important
zstyle ':completion:*:default' menu select=2

# Completing Groping
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'
zstyle ':completion:*' group-name ''

# Completing misc
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'
zstyle ':completion:*' use-cache true
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Directory
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# default: --
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true

# Menu select
zmodload -i zsh/complist
bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^j' vi-down-line-or-history
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char

autoload -Uz cdr
autoload -Uz history-search-end
autoload -Uz modify-current-argument
autoload -Uz smart-insert-last-word
autoload -Uz terminfo
autoload -Uz vcs_info
autoload -Uz zcalc
autoload -Uz zmv
autoload -Uz run-help-git


#viモードでプロンプトを切り替える
# -------------------------------------
# anyenv
# -------------------------------------
if [ -d ${HOME}/.anyenv ] ; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
    for D in `ls $HOME/.anyenv/envs`
    do
        export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
    done
fi

# -------------------------------------
# ranger
# -------------------------------------
# サブシェルを入れ子にしない
function ranger() {
    if [ -z "$RANGER_LEVEL" ]; then
        /usr/local/bin/ranger $@
    else
        exit
    fi
}

[ -n "$RANGER_LEVEL" ] && PS1="$PS1"'(in ranger) '

# -------------------------------------
# dot
# -------------------------------------

export DOT_REPO="https://HipBird@bitbucket.org/HipBird/dotfiles.git"
export DOT_DIR="$HOME/.dotfiles"

# -------------------------------------
# Utilities
# -------------------------------------

# ostype returns the lowercase OS name
ostype() {
    # shellcheck disable=SC2119
    uname | tr "[:upper:]" "[:lower:]"
}

# os_detect export the PLATFORM variable as you see fit
os_detect() {
    export PLATFORM
    case "$(ostype)" in
        *'linux'*)  PLATFORM='linux'   ;;
        *'darwin'*) PLATFORM='osx'     ;;
        *'bsd'*)    PLATFORM='bsd'     ;;
        *)          PLATFORM='unknown' ;;
    esac
}

# is_osx returns true if running OS is Mac
is_osx() {
    os_detect
    if [ "$PLATFORM" = "osx" ]; then
        return 0
    else
        return 1
    fi
}
alias is_mac=is_osx

# is_linux returns true if running OS is GNU/Linux
is_linux() {
    os_detect
    if [ "$PLATFORM" = "linux" ]; then
        return 0
    else
        return 1
    fi
}

# is_bsd returns true if running OS is FreeBSD
is_bsd() {
    os_detect
    if [ "$PLATFORM" = "bsd" ]; then
        return 0
    else
        return 1
    fi
}

# get_os returns OS name of the platform that is running
get_os() {
    local os
    for os in osx linux bsd; do
        if is_$os; then
            echo $os
        fi
    done
}

# has_command returns true if $1 as a shell command exists
has.command() {
    (( $+commands[${1:?too few argument}] ))
    return $status
}

# has_command returns true if $1 as a shell function exists
has.function() {
    (( $+functions[${1:?too few argument}] ))
    return $status
}

# has_command returns true if $1 as a builtin command exists
has.builtin() {
    (( $+builtins[${1:?too few argument}] ))
    return $status
}

# has_command returns true if $1 as an alias exists
has.alias() {
    (( $+aliases[${1:?too few argument}] ))
    return $status
}

# has_command returns true if $1 as an alias exists
has.galias() {
    (( $+galiases[${1:?too few argument}] ))
    return $status
}

# has returns true if $1 exists
has() {
    has.function "$1" || \
        has.command "$1" || \
        has.builtin "$1" || \
        has.alias "$1" || \
        has.galias "$1"

    return $status
}

# chpwd function is called after cd command

if is_osx; then
  chpwd() {
     ls -GF
  }
fi

if is_linux; then
  chpwd() {
     ls -F --color
  }
fi

# -------------------------------------
# aliases
# -------------------------------------

# For mac, aliases
if is_osx; then
    has "qlmanage" && alias ql='qlmanage -p "$@" >&/dev/null'
    alias lb='open -a LaunchBar "$@"'
    alias ls='ls -GF'
    alias emacs='emacs -nw'
fi

if is_linux; then
    alias ls='ls -F --color'
fi

if has 'git'; then
    alias gst='git status'
fi

# Common aliases
alias ..='cd ..'

# Use if colordiff exists
if has 'colordiff'; then
    alias diff='colordiff -u'
else
    alias diff='diff -u'
fi

if has "gomi"; then
    alias -g D="| gomi"
fi

pygmentize_alias() {
    if has "pygmentize"; then
        local get_styles styles style
        get_styles="from pygments.styles import get_all_styles
        styles = list(get_all_styles())
        print('\n'.join(styles))"
        styles=( $(sed -e 's/^  *//g' <<<"$get_styles" | python) )

        style=${${(M)styles:#monokai}:-default}
        cat_alias "$@" | pygmentize -O style="$style" -f console256 -g
    else
        cat -
    fi
}
alias -g P="| pygmentize_alias"

mru() {
    local -a f
    f=(
    ~/.vim_mru_files(N)
    )
    if [[ $#f -eq 0 ]]; then
        echo "There is no available MRU Vim plugins" >&2
        return 1
    fi

    local cmd q k res
    local line ok make_dir i arr
    local get_styles styles style
    while : ${make_dir:=0}; ok=("${ok[@]:-dummy_$RANDOM}"); cmd="$(
        cat <$f \
            | while read line; do [ -e "$line" ] && echo "$line"; done \
            | while read line; do [ "$make_dir" -eq 1 ] && echo "${line:h}/" || echo "$line"; done \
            | awk '!a[$0]++' \
            | perl -pe 's/^(\/.*\/)(.*)$/\033[34m$1\033[m$2/' \
            | fzf --ansi --multi --query="$q" \
            --no-sort --exit-0 --prompt="MRU> " \
            --print-query --expect=ctrl-v,ctrl-x,ctrl-l,ctrl-q,ctrl-r,"?"
            )"; do
        q="$(head -1 <<< "$cmd")"
        k="$(head -2 <<< "$cmd" | tail -1)"
        res="$(sed '1,2d;/^$/d' <<< "$cmd")"
        [ -z "$res" ] && continue
        case "$k" in
            "?")
                cat <<HELP > /dev/tty
usage: vim_mru_files
    list up most recently files
keybind:
  ctrl-q  output files and quit
  ctrl-l  less files under the cursor
  ctrl-v  vim files under the cursor
  ctrl-r  change view type
  ctrl-x  remove files (two-step)
HELP
                return 1
                ;;
            ctrl-r)
                if [ $make_dir -eq 1 ]; then
                    make_dir=0
                else
                    make_dir=1
                fi
                continue
                ;;
            ctrl-l)
                export LESS='-R -f -i -P ?f%f:(stdin). ?lb%lb?L/%L.. [?eEOF:?pb%pb\%..]'
                arr=("${(@f)res}")
                if [[ -d ${arr[1]} ]]; then
                    ls -l "${(@f)res}" < /dev/tty | less > /dev/tty
                else
                    if has "pygmentize"; then
                        get_styles="from pygments.styles import get_all_styles
                        styles = list(get_all_styles())
                        print('\n'.join(styles))"
                        styles=( $(sed -e 's/^  *//g' <<<"$get_styles" | python) )
                        style=${${(M)styles:#monokai}:-default}
                        export LESSOPEN="| pygmentize -O style=$style -f console256 -g %s"
                    fi
                    less "${(@f)res}" < /dev/tty > /dev/tty
                fi
                ;;
            ctrl-x)
                if [[ ${(j: :)ok} == ${(j: :)${(@f)res}} ]]; then
                    eval '${${${(M)${+commands[gomi]}#1}:+gomi}:-rm} "${(@f)res}" 2>/dev/null'
                    ok=()
                else
                    ok=("${(@f)res}")
                fi
                ;;
            ctrl-v)
                nvim -p "${(@f)res}" < /dev/tty > /dev/tty
                ;;
            ctrl-q)
                echo "$res" < /dev/tty > /dev/tty
                return $status
                ;;
            *)
                echo "${(@f)res}"
                break
                ;;
        esac
    done
}

# list galias
alias galias="alias | command grep -E '^[A-Z]'"

# list git branch
git_branch() {
    is_git_repo || return
    has "fzf"   || return

    {
        git branch | sed -e '/^\*/d'
        git branch | sed -n -e '/^\*/p'
    } \
        | fzf --select-1 \
        | sed -e 's/^\*[ ]*//g'
}

alias -g GB='$(git_branch)'

if has "tw"; then
    alias -g TW="| tw --pipe"
    if has "emojify"; then
        alias -g TW="| emojify | tw --pipe"
    fi
fi

git_modified_files() {
    is_git_repo || return

    local cmd q k res ok
    while ok=("${ok[@]:-dummy_$RANDOM}"); cmd="$(
        git status --po \
            | awk '$1=="M"{print $2}' \
            | FZF_DEFAULT_OPTS= fzf --ansi --multi --query="$@" \
            --no-sort --prompt="[C-a:add | C-c:checkout | C-d:diff]> " \
            --print-query --expect=ctrl-d,ctrl-a,ctrl-c \
            --bind=ctrl-z:toggle-all \
            )"; do
        q="$(head -1 <<< "$cmd")"
        k="$(head -2 <<< "$cmd" | tail -1)"
        res="$(sed '1,2d;/^$/d' <<< "$cmd")"
        [ -z "$res" ] && continue
        case "$k" in
            ctrl-c)
                if [[ ${(j: :)ok} == ${(j: :)${(@f)res}} ]]; then
                    git checkout -- "${(@f)res}"
                    ok=()
                else
                    ok=("${(@f)res}")
                fi
                ;;
            ctrl-a)
                git add "${(@f)res}"
                ;;
            ctrl-d)
                git diff "${(@f)res}" < /dev/tty > /dev/tty
                ;;
            *)
                echo "${(@f)res}" < /dev/tty > /dev/tty
                break
                ;;
        esac
    done
}
alias -g GG='$(git_modified_files)'


# -------------------------------------
# keybinds
# -------------------------------------

# Vim-like keybind as default
bindkey -v
# Vim-like escaping jj keybind
bindkey -M viins 'jj' vi-cmd-mode

# Add emacs-like keybind to viins mode
bindkey -M viins '^F'    forward-char
bindkey -M viins '^B'    backward-char
bindkey -M viins '^P'    up-line-or-history
bindkey -M viins '^N'    down-line-or-history
bindkey -M viins '^A'    beginning-of-line
bindkey -M viins '^E'    end-of-line
bindkey -M viins '^K'    kill-line
bindkey -M viins '^R'    history-incremental-pattern-search-backward
bindkey -M viins '\er'   history-incremental-pattern-search-forward
bindkey -M viins '^Y'    yank
bindkey -M viins '^W'    backward-kill-word
bindkey -M viins '^U'    backward-kill-line
bindkey -M viins '^H'    backward-delete-char
bindkey -M viins '^?'    backward-delete-char
bindkey -M viins '^G'    send-break
bindkey -M viins '^D'    delete-char-or-list

bindkey -M vicmd '^A'    beginning-of-line
bindkey -M vicmd '^E'    end-of-line
bindkey -M vicmd '^K'    kill-line
bindkey -M vicmd '^P'    up-line-or-history
bindkey -M vicmd '^N'    down-line-or-history
bindkey -M vicmd '^Y'    yank
bindkey -M vicmd '^W'    backward-kill-word
bindkey -M vicmd '^U'    backward-kill-line
bindkey -M vicmd '/'     vi-history-search-forward
bindkey -M vicmd '?'     vi-history-search-backward

# Original keybind
bindkey -M vicmd 'gg' beginning-of-line
bindkey -M vicmd 'G' end-of-line

# bind P and N for EMACS mode
has 'history-substring-search-up' &&
    bindkey -M emacs '^P' history-substring-search-up
has 'history-substring-search-down' &&
    bindkey -M emacs '^N' history-substring-search-down

# bind k and j for VI mode
has 'history-substring-search-up' &&
    bindkey -M vicmd 'k' history-substring-search-up
has 'history-substring-search-down' &&
    bindkey -M vicmd 'j' history-substring-search-down

# bind P and N keys
has 'history-substring-search-up' &&
    bindkey '^P' history-substring-search-up
has 'history-substring-search-down' &&
bindkey '^N' history-substring-search-down


# Ctrl-R
_peco-select-history() {
    if true; then
        BUFFER="$(
        history 1 \
            | sort -k1,1nr \
            | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' \
            | fzf --query "$LBUFFER"
        )"

        CURSOR=$#BUFFER
        #zle accept-line
        #zle clear-screen
        zle reset-prompt
    else
        if is-at-least 4.3.9; then
            zle -la history-incremental-pattern-search-backward && bindkey "^r" history-incremental-pattern-search-backward
        else
            history-incremental-search-backward
        fi
    fi
}
zle -N _peco-select-history
bindkey '^r' _peco-select-history



gaf() {
  local addfiles
  addfiles=($(git status --short | grep -v '##' | awk '{ print $2 }' | fzf --multi))
  if [[ -n $addfiles ]]; then
    git add ${@:2} $addfiles && echo "added: $addfiles"
  else
    echo "nothing added."
  fi
}

# -------------------------------------
# zplug
# -------------------------------------
# zplugがないときはクローンする
source ~/.zplug/init.zsh || { git clone https://github.com/b4b4r07/zplug.git ~/.zplug && source ~/.zplug/init.zsh }

zplug 'b4b4r07/zplug', at:v2  # don't forget to zplug update --self && zplug update

    local user_symbol="$"
    if [[ $(print -P "%#") =~ "#" ]]; then
        user_symbol = "#"
    fi
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(vi_mode context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
    local user_symbol="$"
    if [[ $(print -P "%#") =~ "#" ]]; then
        user_symbol = "#"
    fi
POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="%{%B%F{white}%K{blue}%} $user_symbol%{%b%f%k%F{blue}%} %{%f%}"
export DEFAULT_USER="$USER"

zplug 'bhilburn/powerlevel9k', use:powerlevel9k.zsh-theme

# commands
zplug "b4b4r07/zsh-gomi", \
    as:command, \
    use:bin/gomi

zplug "mrowa44/emojify", \
as:command

zplug "stedolan/jq", \
    as:command, \
    from:gh-r, \
    frozen:1

zplug 'junegunn/fzf-bin', \
    as:command, \
    from:gh-r, \
    rename-to:fzf, \
    frozen:1

zplug "peco/peco", \
    as:command, \
    from:gh-r, \
    frozen:1

# plugins
zplug "b4b4r07/emoji-cli", \
    if:'(( $+commands[jq] ))', \
on:"junegunn/fzf-bin"

zplug 'b4b4r07/enhancd', \
    use:init.sh

zplug 'zsh-users/zsh-completions'

# zplug 'zsh-users/zsh-autosuggestions'

zplug 'zsh-users/zsh-history-substring-search'

zplug 'zsh-users/zsh-syntax-highlighting', \
    nice:19

zplug "ssh0/dot", \
    use:"*.sh"

zplug "urbainvaes/fzf-marks"

# check コマンドで未インストール項目があるかどうか verbose にチェックし
# false のとき（つまり未インストール項目がある）y/N プロンプトで
# インストールする
if ! zplug check --verbose; then
    printf 'Install? [y/N]: '
    if read -q; then
        echo; zplug install
    fi
fi



if [ -f $(brew --prefix)/etc/brew-wrap ];then
  source $(brew --prefix)/etc/brew-wrap
fi

# プラグインを読み込み、コマンドにパスを通す
zplug load --verbose

alias brew="env PATH=${PATH/\/Users\/EM\/\.anyenv\/envs\/pyenv\/shims:/} brew"
export EDITOR=nvim
