#!/bin/bash

alias gs='git status'
alias gd='git diff'
alias gc='git commit'
alias gl='git log --oneline | head -n'
alias gf='git fetch'
alias la='ls -la'

print_last_branch_commit () {
  if git checkout $1 -q; then
    gl 1;
    git checkout - -q;
  fi
}
alias glc=print_last_branch_commit
