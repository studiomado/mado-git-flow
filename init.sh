#!/bin/bash
isMac=0
if [[ "$OSTYPE" == "darwin"* ]]; then
    isMac=1
    echo "rilevato Mac"
    if [[ $(brew -v) == "" ]]; then
        echo -e 'prima di continuare installare brew: https://brew.sh/index_ite'
        exit
    fi
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
    echo "rilevato GNU Linux"
else
    echo "sistema funzionante solo per Mac o Linux"
    exit
fi
if [[ $(git --version) == "" ]]; then
    echo "installo git..."
    if [[ "$isMac" == "1" ]]; then
        brew install git
    else
        sudo apt-get install git
    fi
fi
if [[ $(git flow version) == "" ]]; then
    echo "installo git-flow..."
    if [[ "$isMac" == "1" ]]; then
        brew install git-flow-avh
    else
        sudo apt-get install git-flow
    fi
fi
chmod +x gim
if [[ "$isMac" == "1" ]]; then
    cp gim /usr/local/bin/gim
else
    sudo cp gim /usr/local/bin/gim
fi
echo "installazione terminata!"
