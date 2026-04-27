import socket
import time

# Target the Server's IP address on the other side of the router
UDP_IP = "10.0.2.5" 
UDP_PORT = 5005
MESSAGE = b"[SIMULATION] Tactical Voice Data Payload"

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

print(f"[*] Initiating transmission to {UDP_IP}:{UDP_PORT}...")

packet_count = 0
while True:
    packet_count += 1
    sock.sendto(MESSAGE, (UDP_IP, UDP_PORT))
    print(f"[+] Transmitted Packet {packet_count} -> Router -> Server")
    time.sleep(1) # Send 1 packet per second
