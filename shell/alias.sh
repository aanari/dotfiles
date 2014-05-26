if ls --color > /dev/null 2>&1; then # GNU `ls`
	colorflag="--color"
else # OS X `ls`
	colorflag="-G"
fi

gittags () {
    ls -1 --sort=time .git/refs/heads/ | while read b; do PAGER='' git log -n1 --color --pretty=format:'%C(yellow)%<(40)%d%Creset %Cred%h%Creset  %<(90)%s %C(green)%>(18)%cr%Creset   %C(bold blue)%>(18)%an%Creset%n' --abbrev-commit $b --; done;
}
alias ctdb='psql -h 127.0.0.1 -U crowdtilt'
alias dbictrace='export DBIC_TRACE=1;export DBIC_TRACE_PROFILE=console'
alias re.pl='cd /$HOME/Projects/crowdtilt-internal-api; perl -Ilib -Ilocallib/lib/perl5 /$HOME/perl5/perlbrew/perls/perl-5.14.2/bin/re.pl'
alias begin="devenv && git checkout -B $1"
alias cloud1="vagrant up cloud1 --provider=aws && vagrant ssh cloud1"
alias perlib="perl -Ilib -Ilocallib/lib/perl5 $1"
alias dbdump='perl -Ilib -Ilocallib/lib/perl5 $HOME/Projects/crowdtilt-internal-api/db_scripts/dbicdump.pl -o 1'
alias gitcleanup='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'
alias realias='$EDITOR ~/.alias; source ~/.alias'

alias sudo='nocorrect sudo'
alias g='git'
alias p='cd ~/Projects'

alias mutt='cd ~/Desktop && mutt'
alias rooibos='ssh rooibos -t -p 22 tmux attach -t 1;/bin/bash'
alias readlink=greadlink
alias ackr="ack --pager='less -R'"

export DANCEBIN_URL="https://paste.crowdtilt.com"

#alias nopastec='DANCEBIN_URL=https://paste.crowdtilt.com nopaste'
alias ctp="prove -Pretty -lvr -j9 --state=slow,save -Ilocallib/lib/perl5"
alias ctp2="prove -MCarp::Always -Pretty -lvr -Ilocallib/lib/perl5"
alias reperl='perl -de0'

# Clean up LaunchServices to remove duplicates in the “Open With” menu
alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

# Canonical hex dump; some systems have this symlinked
command -v hd > /dev/null || alias hd="hexdump -C"

# OS X has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"

export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.Finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.Finder AppleShowAllFiles -bool false && killall Finder"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

alias tmux="TERM=screen-256color-bce tmux"
alias tcli="transmission-cli"
alias ios="open -a /Applications/Xcode.app/Contents/Applications/iPhone\ Simulator.app"
