#!/usr/bin/env ruby

require 'socket.so'

class UDPServer
  def initialize(port)
    @port = port
  end

  def start
    @socket = UDPSocket.new
    @socket.bind("", @port) 
    while true
      message,addr= @socket.recvfrom(1024)
	  puts "receive #{message} from addr: #{addr[3]} port: #{addr[1]}"  
      @socket.send(">> hello client [#{Time.now}]", 0, addr[3], addr[1])
    end
  end
end

server = UDPServer.new(4321)
server.start
