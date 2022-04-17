# Init jenv
if which jenv > /dev/null; then eval "$(jenv init -)"; fi

# Postgresql
export PATH="/usr/local/opt/postgresql/bin:$PATH"

# gpg
export GPG_TTY=$(tty)

# Init nvm
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# Load antigen
source /usr/local/share/antigen/antigen.zsh

# Load the oh-my-zsh's library
antigen use oh-my-zsh

# Syntax highlighting bundle
antigen bundle zsh-users/zsh-syntax-highlighting

# Tell Antigen that you're done.
antigen apply

# Include these plugins in .zshrc plugins=(git docker kubectl)