#!/bin/bash
set -xeu

sudo ip link show wg0 > /dev/null && sudo ip link delete wg0
sudo ip link add dev wg0 type wireguard
sudo wg set wg0 listen-port 51821 private-key ./clientprivatekey peer $(cat ./serverpublickey) allowed-ips 0.0.0.0/0 endpoint 172.17.0.2:51820
sudo ip link set up dev wg0
sudo ip address add dev wg0 10.0.0.2 peer 10.0.0.1
sudo ip r a 8.8.8.8 dev wg0 via 10.0.0.1
sudo ip r a 142.251.33.78 dev wg0 via 10.0.0.1
