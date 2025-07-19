#!/usr/bin/env bash
# FZF-powered shell functions

# Interactive git branch checkout
fco() {
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# Interactive git commit browser with preview
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# Kill process
fkill() {
  local pid
  if [ "$UID" != "0" ]; then
    pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
  else
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
  fi

  if [ "x$pid" != "x" ]; then
    echo $pid | xargs kill -${1:-9}
  fi
}

# cd to selected directory
fcd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# cd into the directory of the selected file
fcdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# Interactive history search
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}

# Find files and open in editor
fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# Modified files in git
fgf() {
  git -c color.status=always status --short |
  fzf --height 50% --border --ansi --multi --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

# Checkout git branch (including remote branches)
fcor() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# Git log browser with commit preview
fgl() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --header "Press CTRL-S to toggle sort" \
      --preview "echo {} | grep -o '[a-f0-9]\{7,\}' | head -1 | xargs -I % git show --color=always % | head -200" \
      --bind "enter:execute:echo {} | grep -o '[a-f0-9]\{7,\}' | head -1 | xargs -I % git show --color=always % | less -R"
}

# Docker container management
fdocker() {
  local cid
  cid=$(docker ps -a | sed 1d | fzf -1 -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker start "$cid" && docker logs -f "$cid"
}

# Switch tmux sessions
ftmux() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf --height 40% --reverse --query="$1" --select-1 --exit-0) &&
  tmux switch-client -t "$session"
}

# Search and install brew packages
fbrew() {
  local inst=$(brew search "$@" | fzf -m)
  if [[ $inst ]]; then
    for prog in $(echo $inst); do
      brew install $prog
    done
  fi
}

# Open recent files in vim
fvim() {
  local files
  files=$(grep '^>' ~/.viminfo | cut -c3- |
          while read line; do
            [ -f "${line/\~/$HOME}" ] && echo "$line"
          done | fzf-tmux -d -m -q "$*" -1) && vim ${files//\~/$HOME}
}

# Directory bookmarks
if [ ! -f ~/.bookmarks ]; then
  touch ~/.bookmarks
fi

# Add bookmark
bmadd() {
  echo "$(pwd)|$1" >> ~/.bookmarks
}

# Jump to bookmark
bmjump() {
  local bookmark
  bookmark=$(cat ~/.bookmarks | fzf --height 40% --reverse | cut -d'|' -f1)
  [ -n "$bookmark" ] && cd "$bookmark"
}

# List bookmarks
bmlist() {
  cat ~/.bookmarks | column -t -s '|'
}

# Remove bookmark
bmrm() {
  local bookmark
  bookmark=$(cat ~/.bookmarks | fzf --height 40% --reverse)
  if [ -n "$bookmark" ]; then
    grep -v "^$bookmark$" ~/.bookmarks > ~/.bookmarks.tmp
    mv ~/.bookmarks.tmp ~/.bookmarks
  fi
}