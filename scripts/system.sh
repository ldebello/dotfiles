#!/bin/sh

# Configure profile file
cp system/.profile ~/.profile
ln -s ~/.profile ~/.zprofile
source ~/.profile

# Adding JVMs
jenv enable-plugin export
jenv add `/usr/libexec/java_home -v '8'`
jenv add `/usr/libexec/java_home -v '11'`
jenv global 1.8

# Git configuration
git config --global user.name "Luis De Bello"
git config --global user.email luis.debello@mulesoft.com

# Configure nvm
nvm install 8.9.4
npm login --registry=https://nexus3.build.msap.io/repository/npm-internal/ --scope=@mulesoft

# Start all brew services
brew services start --all

# Configure mysql password
read -p "Do you want to configure mysql password? " ANSWER
until [[ "$ANSWER" =~ [A-Za-z] ]]; do
    read -p "Do you want to configure mysql password? " ANSWER
done

if [ "$ANSWER" == "y" ]; then
    echo "Enter new password for mysql: "
    read -s NEW_PASSWORD

mysql -u root <<MYSQL_INPUT
ALTER USER 'root'@'localhost' IDENTIFIED BY '$NEW_PASSWORD';
MYSQL_INPUT
fi

# Configure timezone
sudo systemsetup -settimezone America/Argentina/Buenos_Aires

# Configure menu bar
BATTERY=`grep "Battery.menu" ~/Library/Preferences/com.apple.systemuiserver.plist -c`
if [ $BATTERY == 0 ]; then
    echo "Adding Battery status to menu" 
    open '/System/Library/CoreServices/Menu Extras/Battery.menu'
fi
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

VOLUME=`grep "Volume.menu" ~/Library/Preferences/com.apple.systemuiserver.plist -c`
if [ $VOLUME == 0 ]; then
    echo "Adding Volume status to menu" 
    open '/System/Library/CoreServices/Menu Extras/Volume.menu'
fi
osascript -e "set Volume 0"

killall SystemUIServer

# Configure dock icons
dockutil --add /Applications/iTerm.app
dockutil --add /Applications/Slack.app
dockutil --add /Applications/Visual\ Studio\ Code.app
dockutil --add /Applications/IntelliJ\ IDEA.app
dockutil --add /Applications/Postman.app
dockutil --add /Applications/MySQLWorkbench.app
dockutil --add /Applications/pgAdmin\ 4.app

# Configure DBs
createuser amc_deployer_db
createdb amc_deployer_db -O amc_deployer_db -W

# Install requests for python
sudo easy_install -U requests