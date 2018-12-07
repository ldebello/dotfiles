#!/bin/sh

brew tap caskroom/versions
brew tap AdoptOpenJDK/openjdk

brew install jenv
brew install maven
brew install gpg
brew install jq
brew install xmlstarlet

brew cask install adoptopenjdk8
brew cask install zulu8
brew cask install zulu

brew cask install iterm2
brew cask install slack
brew cask install visual-studio-code
brew cask install caffeine
brew cask install intellij-idea