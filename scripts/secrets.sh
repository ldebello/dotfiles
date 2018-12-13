#!/bin/sh

echo "Do you want to configure your secrets?"
read ANSWER

if [ "$ANSWER" == "y" ] 
then
    echo "Please, provide your last pass username:"
    read LAST_PASS_USERNAME
    lpass login $LAST_PASS_USERNAME

    echo "Importing keys"
    mkdir -p .ssh
    lpass show Personal/ssh-private --notes > ~/.ssh/id_rsa
    lpass show Personal/ssh-public --notes > ~/.ssh/id_rsa.pub

    lpass show Personal/gpg-public --notes > ~/pubkey.asc
    lpass show Personal/gpg-private --notes > ~/privkey.asc

    echo "Importing Maven settings"
    mkdir -p .m2
    lpass show Personal/maven --notes > ~/.m2/settings.xml

    gpg --import ~/pubkey.asc
    gpg --allow-secret-key-import --import ~/privkey.asc

    rm ~/pubkey.asc
    rm ~/privkey.asc

    lpass logout -f

    echo "Please, provide repo for secrets:"
    read SECRETS_REPO
    git clone $SECRETS_REPO ~/.password-store
fi
