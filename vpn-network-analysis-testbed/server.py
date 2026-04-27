import socket
import time

UDP_IP = "0.0.0.0" # Listen on all network interfaces
UDP_PORT = 5005

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind((UDP_IP, UDP_PORT))

print(f"[*] Server listening securely on Port {UDP_PORT}...")

while True:
    data, addr = sock.recvfrom(1024) # 1024 byte buffer
    print(f"[{time.strftime('%X')}] Packet Received from {addr}: {data.decode('utf-8')}")
