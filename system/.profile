# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Init jenv
if which jenv > /dev/null; then eval "$(jenv init -)"; fi

# gpg
export GPG_TTY=$(tty)
