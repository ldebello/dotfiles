#!/bin/sh

# Configure profile file
cp system/.profile ~/.profile
ln -s ~/.profile ~/.zprofile
source ~/.profile

# Adding JVMs
jenv enable-plugin export
jenv add `/usr/libexec/java_home`

# Git configuration
git config --global user.name "Luis De Bello"
git config --global user.email luisdebello@gmail.com
