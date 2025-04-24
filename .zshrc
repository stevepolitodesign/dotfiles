# ==== Environment Variables ====

export VISUAL=vim
export EDITOR=$VISUAL

# ==== Aliases ====

# Unix
alias ll="ls -al"
alias ln="ln -v"
alias mkdir="mkdir -p"
alias e="$EDITOR"
alias v="$VISUAL"

# Bundler
alias b="bundle"
alias besf="bundle exec standardrb --fix"

# Rails
alias migrate="bin/rails db:migrate db:rollback && bin/rails db:migrate db:test:prepare"
alias s="rspec"
alias t="bin/rails test"
alias ta="bin/rails test:all"
alias ra="bin/rubocop -a"

# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'

# git
alias gup="git fetch origin;git rebase origin/main"
alias gcl="git log -1 --pretty=%B | pbcopy"

# https://www.atlassian.com/git/tutorials/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# ==== Key Bindings ====

bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey "^Q" push-line-or-edit

# ==== Functions ====

# fzf reverse search
fzf-history-widget() {
  BUFFER=$(fc -l -n 1 | fzf --height 40% --layout=reverse --border)
  CURSOR=$#BUFFER
}
zle -N fzf-history-widget
bindkey '^R' fzf-history-widget

# git
g() {
  if [[ $# -gt 0 ]]; then
    git "$@"
  else
    git status
  fi
}

# ==== Tool Initialization ====

# Starship
eval "$(starship init zsh)"

# asdf
. "$HOME/.asdf/asdf.sh"
