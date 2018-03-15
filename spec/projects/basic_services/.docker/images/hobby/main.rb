Process.uid = (Process::UID.from_name 'nobody')

require 'puma'
require_relative '/app/root'

server = Puma::Server.new Root.new
server.add_tcp_listener '0.0.0.0', 8080
server.run
sleep
