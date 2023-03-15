#!/bin/bash
set -xeu


SERVER_PRIVATE_KEY=$(wg genkey)
CLIENT_PRIVATE_KEY=$(wg genkey)

cat >$HOME/mitmproxy/wireguard.conf <<EOF
{
    "server_key": "$SERVER_PRIVATE_KEY",
    "client_key": "$CLIENT_PRIVATE_KEY"
}
EOF

SERVER_PUBLIC_KEY=$(echo $SERVER_PRIVATE_KEY | wg pubkey)
CLIENT_PUBLIC_KEY=$(echo $CLIENT_PRIVATE_KEY | wg pubkey)

echo $CLIENT_PRIVATE_KEY > $HOME/mitmproxy/clientprivatekey
echo $SERVER_PUBLIC_KEY > $HOME/mitmproxy/serverpublickey
