#!/usr/bin/env ruby

require 'socket.so'

class UDPClient
  def initialize(host, port)
    @host = host
    @port = port
  end

  def start
    @socket = UDPSocket.open
    while true
      @socket.send(">> say hello to udp server [i#{Time.now}]", 0, @host, @port)
	  message,addr= @socket.recvfrom(1024)
	  puts "receive #{message} from addr: #{addr[3]} port: #{addr[1]}"  
      sleep 2
    end
  end
end

client = UDPClient.new("localhost", 4321) # 10.10.129.139 is the IP of UDP server
client.start

