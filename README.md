# 使用ruby脚本测试udp 通讯 #

ruby 脚本展示udp 通讯方式.

## userver ##
服务端绑定端口接收客户端的发送的消息，然后发送消息给客户端
```ruby
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
```
## uclient ##
客户端发送消息给服务器，接着接收服务器的回应

```ruby
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

```
