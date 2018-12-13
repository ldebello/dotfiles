#!/bin/sh

# Adding JVMs
jenv enable-plugin export
jenv add `/usr/libexec/java_home -v '8'`
jenv add `/usr/libexec/java_home -v '11'`
jenv global 1.8

# Git configuration
git config --global user.name "Luis De Bello"
git config --global user.email luis.debello@mulesoft.com

# Configure profile file
cp system/.profile ~/.profile
ln -s ~/.profile ~/.zprofile

# Configure nvm
nvm install 8.9.4
npm login --registry=https://nexus3.build.msap.io/repository/npm-internal/ --scope=@mulesoft