def initialize directory: '.', docker_socket: 'tcp://127.0.0.1:2375'
  check_if_docker_is_available_at docker_socket

  @directory = File.expand_path directory
  @images_directory = "#{@directory}/.docker/images"
end

def run
  images = (Dir.entries(@images_directory) - ['.', '..']).map do |name|
    Image.new name, directory: "#{@images_directory}/#{name}"
  end

  images.each do |image|
    image.build unless image.exist?
  end
end

private
  def check_if_docker_is_available_at docker_socket
    Docker.url = docker_socket
    Docker.version
  #rescue Excon::Error::Socket
  end
