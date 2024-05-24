import socket
import sys

HOST, PORT = "localhost", 9999
data = "".join(sys.argv[1:])

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.connect((HOST, PORT))
    s.sendall(bytes(data + "\n", "utf-8"))
    
    received = str(s.recv(1024), "utf-8")

