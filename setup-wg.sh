#!/usr/bin/bash

read -p "WG interface name: " wgname
read -p "WG Address: " wgaddr

wgdir="/etc/wireguard"
mkdir -p $wgdir/$wgname/
wg genkey | tee $wgdir/$wgname/privatekey | wg pubkey > $wgdir/$wgname/publickey

pubkey=$(cat $wgdir/$wgname/publickey)
privkey=$(cat $wgdir/$wgname/privatekey)
wgcfg=$wgdir/$wgname.conf

echo "[Interface]
PrivateKey=$privkey
Address=$wgaddr/32
#Listen=
MTU=1450

[Peer]
Endpoint=
PublicKey=
#PresharedKey=
AllowedIPs=
PersistentKeepalive=25
" > $wgcfg
