#!/usr/bin/env bash

# GPG_KEY=9D4B2B6EB8F97156D19669A9FF0812D491B96798
# GPG_KEY_SERVER=hkps://keys.mailvelope.com

GPG_KEY=90BD75EBBB8E95CB3DA6078F94A4029AB4B35DAE
GPG_KEY_SERVER=hkps://keyserver.ubuntu.com

gpg --keyserver $GPG_KEY_SERVER --receive-keys $GPG_KEY
gpg --export $GPG_KEY > /usr/share/keyrings/parity.gpg

echo 'deb [signed-by=/usr/share/keyrings/parity.gpg] https://releases.parity.io/deb release main' > /etc/apt/sources.list.d/parity.list
apt update

apt install parity-keyring polkadot -y


output=$'POLKADOT_CLI_ARGS="\n'
for arg in "$@"; do
    output+="$arg"$'\n'
done
output+=$'"\n'

echo "$output" > /etc/default/polkadot

echo "done"
