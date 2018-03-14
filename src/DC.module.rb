require 'docker'

def self.run
  establish_connection
end

DOCKER_TCP_DEFAULT = 'tcp://127.0.0.1:2375'

# If there is no Docker at unix:///var/run/docker.sock,
# try the tcp default.
def self.establish_connection
  Docker.version
rescue Excon::Error::Socket
  if Docker.url == DOCKER_TCP_DEFAULT
    fail $!
  else
    Docker.url = DOCKER_TCP_DEFAULT
    retry
  end
end
