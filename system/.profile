# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Init jenv
if which jenv > /dev/null; then eval "$(jenv init -)"; fi

# gpg
export GPG_TTY=$(tty)

# Load Antigen
source /opt/homebrew/share/antigen/antigen.zsh

# Load oh-my-zsh library
antigen use oh-my-zsh

# Load bundles from the default repo (oh-my-zsh)
antigen bundle git
antigen bundle docker
antigen bundle kubectl

# Load bundles from external repos
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

# Tell Antigen that you're done
antigen apply
