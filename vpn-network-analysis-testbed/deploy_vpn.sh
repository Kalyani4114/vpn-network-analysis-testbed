#!/bin/bash
echo "[*] Installing WireGuard and firewall tools in containers..."
docker exec vpn_router apt-get update && docker exec vpn_router apt-get install -y wireguard iptables
docker exec client_node apt-get update && docker exec client_node apt-get install -y wireguard iptables

echo "[*] Generating cryptographic keys..."
ROUTER_PRIV=$(docker exec vpn_router wg genkey)
ROUTER_PUB=$(echo $ROUTER_PRIV | docker exec -i vpn_router wg pubkey)
CLIENT_PRIV=$(docker exec client_node wg genkey)
CLIENT_PUB=$(echo $CLIENT_PRIV | docker exec -i client_node wg pubkey)

echo "[*] Provisioning Router VPN Configuration..."
docker exec -i vpn_router sh -c "cat > /etc/wireguard/wg0.conf << 'EOF'
[Interface]
Address = 10.8.0.1/24
ListenPort = 51820
PrivateKey = $ROUTER_PRIV

[Peer]
PublicKey = $CLIENT_PUB
AllowedIPs = 10.8.0.2/32
EOF"

echo "[*] Provisioning Client VPN Configuration..."
docker exec -i client_node sh -c "cat > /etc/wireguard/wg0.conf << 'EOF'
[Interface]
Address = 10.8.0.2/24
PrivateKey = $CLIENT_PRIV

[Peer]
PublicKey = $ROUTER_PUB
Endpoint = 10.0.1.10:51820
AllowedIPs = 10.0.2.0/24, 10.8.0.0/24
EOF"

echo "[*] Initiating secure tunnels..."
docker exec vpn_router wg-quick up wg0
docker exec client_node wg-quick up wg0

echo "[+] Cryptographic Layer Deployed Successfully!"
