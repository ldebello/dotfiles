# Init jenv
if which jenv > /dev/null; then eval "$(jenv init -)"; fi

# Postgresql 9.6
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"

# Init nvm
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh