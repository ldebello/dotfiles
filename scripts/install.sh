#!/bin/sh

REPOS=$HOME/repos
DOTFILES=$REPOS/dotfiles
DOTFILES_REPO=https://github.com/ldebello/dotfiles.git

info () {
  MESSAGE=$1
  printf "\r  [ \033[00;34m..\033[0m ] $MESSAGE\n"
}

user () {
  MESSAGE=$1
  printf "\r  [ \033[0;33m??\033[0m ] $MESSAGE\n"
}

success () {
  MESSAGE=$1
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $MESSAGE\n"
}

fail () {
  MESSAGE=$1
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $MESSAGE\n"
  echo ''
  exit
}

main() {
  info "Installing dotfiles"

  if [ "$(uname)" == "Darwin" ]; then
    info "Running on OSX"

    info "Installing Homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    success "Homebrew installed"

    info "Cloning dotfiles into $REPOS"
    mkdir -p $REPOS
    cd $REPOS
    git clone $DOTFILES_REPO $DOTFILES
    cd $DOTFILES
    info "dotfiles cloned"

    info "Brewing all the things"
    source scripts/brew.sh
    success "Homebrew deps installed"

    info "Configuring secrets"
    source scripts/secrets.sh
    success "Secrets were configured"

    info "Configuring bookmarks"
    source scripts/bookmarks.sh
    success "Bookmarks were configured"

    info "Configuring system"
    source scripts/system.sh
    success "System was configured"

    info "Configuring jEnv"
    source scripts/jenv-plugins.sh
    success "jEnv was configured"
    
    info "Clean up"
    cd ~
    rm -rf $DOTFILES
    
    info "Installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    success "oh-my-zsh installed"
  fi

  success "Installed dotfiles"
}

main
