#!/bin/sh

read -p "Do you want to configure your secrets? " ANSWER
until [[ "$ANSWER" =~ [A-Za-z] ]]; do
    read -p "Do you want to configure your secrets? " ANSWER
done

if [ "$ANSWER" == "y" ]; then
    echo "Please, provide your last pass username:"
    read LAST_PASS_USERNAME
    lpass login $LAST_PASS_USERNAME

    echo "Importing SSH keys"
    mkdir -p ~/.ssh
    lpass show Personal/ssh-private --notes > ~/.ssh/id_rsa
    lpass show Personal/ssh-public --notes > ~/.ssh/id_rsa.pub
    chmod 400 ~/.ssh/id_rsa

    echo "Insert password for private key"
    ssh-add -K

    echo "Importing GPG keys"
    lpass show Personal/gpg-public --notes > ~/pubkey.asc
    lpass show Personal/gpg-private --notes > ~/privkey.asc

    gpg --import ~/pubkey.asc
    gpg --allow-secret-key-import --import ~/privkey.asc

    rm ~/pubkey.asc
    rm ~/privkey.asc

    lpass logout -f

    echo "Please, provide repo for secrets:"
    read SECRETS_REPO
    git clone $SECRETS_REPO ~/.password-store
fi
