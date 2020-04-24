# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ALL_PROXY=socks5://127.0.0.1:1080

# Path to your oh-my-zsh installation.
export ZSH=/Users/zhm/.oh-my-zsh

export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk-11.0.2.jdk/Contents/Home
# PATH=$JAVA_HOME/bin:$PATH
# export JAVA_HOME
# export PATH

export MAVEN_HOME=/usr/local/Cellar/maven/3.5.3/libexec
# PATH=$MAVEN_HOME/bin:$PATH
# export MAVEN_HOME
# export PATH


export MYSQL_HOME="/usr/local/opt/mysql@5.7/bin"
export ANT_HOME="/usr/local/opt/ant@1.9/bin"

export NODE_HOME="/usr/local/opt/node@8"
export LDFLAGS="-L/usr/local/opt/node@8/lib"
export CPPFLAGS="-I/usr/local/opt/node@8/include"

export JAVACC=/Users/zhm/CodeTool/javacc-5.0
export PATH=$NODE_HOME/bin:$MAVEN_HOME/bin:$JAVA_HOME/bin:$JAVACC/bin:$MYSQL_HOME:$ANT_HOME:$PATH

# export JAVACC
# export PATH

export HOMEBREW_BOTTLE_DOMAIN='https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles'

eval $(thefuck --alias FUCK)

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

ZSH_THEME="powerlevel10k/powerlevel10k"
# POWERLINE_PATH="short"
#POWERLINE_HIDE_HOST_NAME="true"
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir rbenv vcs)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time dir_writable root_indicator background_jobs history battery)
# POWERLEVEL9K_PROMPT_ON_NEWLINE=true
# POWERLINE_HIDE_USER_NAME="true"
# POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
# POWERLEVEL9K_SHORTENDELIMITER=""
# POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"



# -------------------------------- POWERLEVEL ---------------------------------

POWERLEVEL9K_MODE=nerdfont-complete
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K=truncate_beginning
POWERLEVEL9K_TIME_BACKGROUND=black
POWERLEVEL9K_TIME_FOREGROUND=white
POWERLEVEL9K_TIME_FORMAT=%D{%I:%M}
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_VCS_CLEAN_FOREGROUND=black
POWERLEVEL9K_VCS_CLEAN_BACKGROUND=green
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=black
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=yellow
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=white
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=black
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=black
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=blue
POWERLEVEL9K_FOLDER_ICON=
POWERLEVEL9K_STATUS_OK_IN_NON_VERBOSE=true
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
POWERLEVEL9K_VCS_UNTRACKED_ICON=●
POWERLEVEL9K_VCS_UNSTAGED_ICON=±
POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON=↓
POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON=↑
POWERLEVEL9K_VCS_COMMIT_ICON=' '
POWERLEVEL9K_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=
POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL=
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX='%F{blue}╭─'
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX='%F{blue}╰%f '
POWERLEVEL9K_CUSTOM_OS_ICON='echo   $(whoami) '
POWERLEVEL9K_CUSTOM_OS_ICON_BACKGROUND=red
POWERLEVEL9K_CUSTOM_OS_ICON_FOREGROUND=white
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(custom_os_icon root_indicator ssh dir dir_writable vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time status background_jobs time ram)

if [[ $(tty) == /dev/pts/* ]]
then
	source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme 2> /dev/null || \
		echo -e '\033[33m[ ! ]\033[0m ZSH powerlevel10k not installed'
else
	clear
	echo
	echo
fi


switch_powerlevel_multiline_prompt(){
	[ $POWERLEVEL9K_PROMPT_ON_NEWLINE = true ] \
		&& POWERLEVEL9K_PROMPT_ON_NEWLINE=false \
		|| POWERLEVEL9K_PROMPT_ON_NEWLINE=true

	zle && zle accept-line
}
zle -N switch_powerlevel_multiline_prompt
bindkey ^P switch_powerlevel_multiline_prompt


# POWERLEVEL9K_MODE="nerdfont-complete"

# POWERLEVEL9K_PROMPT_ON_NEWLINE=true
# POWERLEVEL9K_RPROMPT_ICON_LEFT=true

# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir_writable user dir vcs )
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time root_indicator background_jobs  disk_usage ram time )
# # time os_icon
# POWERLEVEL9K_NODE_VERSION_FOREGROUND="black"
# POWERLEVEL9K_TIME_ICON=""
# POWERLEVEL9K_NEWLINE_ICON="\uF09C"
# POWERLEVEL9K_TIME_ICON_COLOR='green'

# POWERLEVEL9K_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL="\ue0b2"

# POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL="\ue0b0"

# POWERLEVEL9K_WHITESPACE_BETWEEN_LEFT_SEGMENTS=" "
# POWERLEVEL9K_WHITESPACE_BETWEEN_RIGHT_SEGMENTS=""

# POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR_ICON="\ue0b0"
# POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR_ICON="\ue0b1"
# POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR_ICON="\ue0b2"
# POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR_ICON="\ue0b3"

# POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX_ICON="%F{blue}"$'\u256D\u2500'"%F{white}"
# POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX_ICON="%F{blue}"$'\u2570\uf460'"%F{white}"

# POWERLEVEL9K_USER_ROOT_ICON="\uF09C"
# POWERLEVEL9K_USER_SUDO_ICON="\uF09C"
# POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"

# POWERLEVEL9K_CUSTOM_SEGMENT="echo "
# POWERLEVEL9K_CUSTOM_SEGMENT_BACKGROUND="black"
# POWERLEVEL9K_CUSTOM_SEGMENT_FOREGROUND="white"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias cat='bat'
alias ping='prettyping --nolegend'
alias preview="fzf --preview 'bat --color \"always\" {}'"
# 支持在 VS Code 里用 ctrl + o 来打开选择的文件
# export FZF_DEFAULT_OPTS = "--bind='ctrl-o:execute(code {})+abort'"
# --color dark 使用颜色方案
# -rr 只读模式（防止误删和运行新的 shell 程序）
# --exclude 忽略不想操作的目录
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
alias help="tldr"

# Edit shortcuts for config files
alias sshconfig="${EDITOR:-vim} ~/.ssh/config"
alias zshrc="${EDITOR:-vim} ~/.zshrc && source ~/.zshrc && echo Zsh config edited and reloaded."

# SSH helper
alias sshclear="rm ~/.ssh/multiplex/* -f && echo SSH connection cache cleared;"
alias sshlist="echo Currently open ssh connections && echo && l ~/.ssh/multiplex/"

alias c="clear"
alias h="history"
alias path="echo -e ${PATH//:/\\n}"

# Date and Time Alias
alias d="date + %F"
alias now="date + '%T'"
alias nowtime=now
alias nowdate="date + '%m-%d-%Y'"

alias svi="sudo vim"

# Show open ports
alias ports="netstat -tulanp"

# Prettify the Output of Various Commands
alias dfc="df -hP | column -t"
alias mount="mount | column -t"

# lsd
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'


. /Users/zhm/myScript/z.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
