# 🛡️ VPN & Network Traffic Analysis Testbed

## 📑 Abstract & Problem Statement
In high-security tactical environments, engineers constantly battle the trade-off between **Cryptographic Security** and **Network Performance**. Heavy encryption (like AES-GCM) often introduces latency, bottlenecking real-time communication. 

This repository houses an isolated, containerized Network Traffic Analysis Testbed. It is engineered from scratch to mathematically quantify "cryptographic overhead" by simulating a multi-node tactical network, executing kernel-level encryption, and validating payload obfuscation via automated Deep Packet Inspection (DPI).

---

## 🏗️ Systems Architecture

The environment provisions a 100% isolated virtual topology using Docker and custom subnets.

- **Client Node:** Simulates the tactical data sender.
- **VPN Router:** The central network gateway enforcing strict routing rules.
- **Server Node:** Simulates the secure receiver headquarters.

### **Core Technologies Employed**
- **Routing:** `iproute2`, `iptables` (Forcing data strictly through encrypted pipes).
- **Cryptography:** WireGuard `wg0` interface operating at the Linux kernel level.
- **Validation & DPI:** Python 3, `Scapy`, `tcpdump`.
- **Benchmarking:** `iperf3`, Wireshark.

---

# 🚀 Execution & Deployment Guide

## 📌 Prerequisites
- A Linux environment (Debian/Ubuntu/Kali)
- Docker and Docker Compose installed
- `root` or `sudo` privileges

---

## ⚙️ Step 1: Provision the Infrastructure

Deploy the isolated nodes. (Container networking capabilities are elevated via `--cap-add=NET_ADMIN` to allow kernel modifications).

```bash
sudo docker-compose up -d
```

---

## 🔐 Step 2: Establish Cryptographic Tunnel

Execute the deployment script to generate asymmetric keys, construct the `wg0` interface (`IP: 10.8.0.2`), and enforce `iptables` routing protocols:

```bash
sudo ./deploy_vpn.sh
```

---

## 📡 Step 3: Simulate Tactical Traffic

Open two distinct terminal sessions to initiate the communication pipeline.

### 🖥️ Listener (Server Node)

```bash
sudo docker exec -it server_node python /server.py
```

### 💻 Sender (Client Node)

```bash
sudo docker exec -it client_node python /client.py
```

---

## 🔍 Step 4: Security Validation (Automated DPI)

Execute the custom Scapy workflow to parse raw datagrams and mathematically prove payload obfuscation:

```bash
python3 dpi_analyzer.py
```

---

# 📊 Analytics & Performance Results

Using `iperf3`, the testbed was subjected to maximum throughput stress tests over the encrypted tunnel. The analytics proved that the architecture successfully mitigates cryptographic overhead:

🟢 **Throughput:** Maintained a constant `10.0 Mbits/sec`

🟢 **Packet Loss:** `0%` (`0 out of 9139 datagrams lost`)

🟢 **Jitter:** `0.034 ms` (Microscopic delay, highly optimized for real-time streaming)

---

# 📸 Architectural Visual Proofs

## 1️⃣ Automated Deep Packet Inspection
Python (`Scapy`) output mathematically proving that all intercepted payloads are fully obfuscated by AES-GCM.

---

## 2️⃣ Performance Benchmarking
`iperf3` metrics proving zero packet loss and minimal latency across the tunnel.

---

## 3️⃣ Secure Tactical Routing
Server node successfully processing incoming simulated payloads strictly via the `10.8.0.2` WireGuard interface.

---

## 4️⃣ Protocol Visualization
Wireshark graphical interface confirming secure encapsulation of datagrams.
