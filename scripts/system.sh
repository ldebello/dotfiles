#!/bin/sh

cp system/.profile ~/.profile

ln -s ~/.profile ~/.zprofile

git config --global user.name "Luis De Bello"
git config --global user.email luis.debello@mulesoft.com