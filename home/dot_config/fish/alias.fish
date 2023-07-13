# Basic
alias .. "cd .."
alias ... "cd ../.."

alias la "ls -Gla"
alias ld 'ls -l | grep "^d"'
alias ll 'ls -ahlF'
if type -q exa
    alias l exa
    alias la 'exa --long --all --group --header --binary --links --inode --blocks'
    alias ld 'exa --long --all --group --header --list-dirs'
    alias ll 'exa --long --all --group --header --git'
    alias lt='exa --long --all --group --header --tree --level'
end

if type -q bat
    alias cat 'bat --paging=never'
end

# NOTE: https://github.com/asdf-community/asdf-direnv
if type -q asdf -a asdf exec direnv 1>&2 2>/dev/null
    test $status -eq 0
    alias direnv "asdf exec direnv"
end

# kitty
if test "$TERM" = xterm-kitty
    alias icat="kitty +kitten icat"
    alias diff="kitty +kitten diff"
    alias ssh="kitty +kitten ssh"
end

# editor
alias v nvim
alias vi nvim
alias vim nvim
alias e emacsclient
alias ec "emacsclient -c"

# git
alias g git
alias ga "git add"
alias gb "git branch"
alias gba "git branch -a"
alias gbd "git branch -D"
alias gca "git commit -a -m"
alias gcm "git commit -m"
alias gco "git checkout"
alias gcob "git checkout -b"
alias gcp "git cherry-pick"
alias gd "git diff"
alias gdc "git diff --cached"
alias gl "git lg"
alias gm "git merge --no-ff"
alias gp "git push"
alias gpom "git pull origin master"
alias gpt "git push --tags"
alias grh "git reset --hard"
alias grs "git reset --soft"
alias gst "git status -sb --ignore-submodules"
alias undopush "git push -f origin HEAD^:master"

# docker / k8s
alias d docker

#################################
### Network Related
#################################

alias localip "ipconfig getifaddr en1"
alias ips "ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ and print $1'"
alias whois "whois -h whois-servers.net"

# View HTTP traffic
alias sniff "sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump "sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

function server --description "Start an HTTP server from a directory"
    open http://localhost:8080/
    and python2 -m SimpleHTTPServer 8080
end

function digga --description "All the dig info"
    dig +nocmd $argv[1] any +multiline +noall +answer
end

alias myip="curl -s checkip.dyndns.org | grep -Eo '[0-9\.]+'"

################################
###  Unix Related
################################
# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"

# File size
alias fs="stat -f \"%z bytes\""

# ROT13-encode text. Works for decoding, too! ;)
alias rot13='tr a-zA-Z n-za-mN-ZA-M'

function randpw --description "generate a random password"
    dd if=/dev/urandom bs=1 count=16 2>/dev/null | base64 | rev | cut -b 2- | rev
end

function cd --description "auto ls for each cd"
    if [ -n $argv[1] ]
        builtin cd $argv[1]
        and ls -AF
    else
        builtin cd ~
        and ls -AF
    end
end

function rename --description "Rename a symbol recursively in a folder"
    rg -l "$argv[1]" | xargs -I\{\} perl -i -pe "s/$argv[1]/$argv[2]/g" \{\}
end

# Taken from: https://github.com/dideler/dotfiles/blob/master/functions/extract.fish
function extract --description "Expand or extract bundled & compressed files"
    set --local ext (echo $argv[1] | awk -F. '{print $NF}')
    switch $ext
        case tar # non-compressed, just bundled
            tar -xvf $argv[1]
        case gz
            if test (echo $argv[1] | awk -F. '{print $(NF-1)}') = tar # tar bundle compressed with gzip
                tar -zxvf $argv[1]
            else # single gzip
                gunzip $argv[1]
            end
        case tgz # same as tar.gz
            tar -zxvf $argv[1]
        case bz2 # tar compressed with bzip2
            tar -jxvf $argv[1]
        case rar
            unrar x $argv[1]
        case zip
            unzip $argv[1]
        case '*'
            echo "unknown extension"
    end
end
