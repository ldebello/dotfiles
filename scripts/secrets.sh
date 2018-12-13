#!/bin/sh

echo "Do you want to configure your secrets?"
read ANSWER

if [ "$ANSWER" == "yes" ] 
then
    echo "Please, provide your last pass username:"
    read LAST_PASS_USERNAME
    lpass login $LAST_PASS_USERNAME

    echo "Importing keys"
    lpass show Personal/gpg-private --notes > ~/.ssh/id_rsa
    lpass show Personal/gpg-private --notes > ~/.ssh/id_rsa.pub

    lpass show Personal/gpg-private --notes > ~/pubkey.asc
    lpass show Personal/gpg-private --notes > ~/privkey.asc

    gpg --import ~/pubkey.asc
    gpg --allow-secret-key-import --import ~/privkey.asc

    rm ~/pubkey.asc
    rm ~/privkey.asc

    lpass logout

    echo "Please, provide repo for secrets:"
    read SECRETS_REPO
    git clone $SECRETS_REPO ~/.password-store
fi
