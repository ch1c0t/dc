def initialize directory: '.', docker_socket: 'tcp://127.0.0.1:2375'
  check_if_docker_is_available_at docker_socket

  @directory = File.expand_path directory

  @images_directory = "#{@directory}/.docker/images"
  @images = prepare_images

  @services_file = "#{@directory}/.docker/services.yml"
end

attr_reader :images, :containers

def run
  build_images
  prepare_services
end

def rebuild_images
  images.each do |image|
    image.tag "before_rebuild.#{Time.now.to_i}"
    image.build
  end
end

private
  def check_if_docker_is_available_at docker_socket
    Docker.url = docker_socket
    Docker.version
  #rescue Excon::Error::Socket
  end

  def prepare_images
    if Dir.exist? @images_directory
      (Dir.entries(@images_directory) - ['.', '..']).map do |name|
        Image.new name, directory: "#{@images_directory}/#{name}"
      end
    else
      []
    end
  end

  def build_images
    images.each do |image|
      image.build unless image.exist?
    end
  end

  def prepare_services
    if File.exist? @services_file
      hash = YAML.load_file @services_file

      images = hash.keys.map do |name|
        Image.new name, directory: "#{@directory}/#{name}"
      end

      images.each do |image|
        image.build unless image.exist?
      end
        
      @containers = hash.map do |name, value|
        ports = if value.is_a?(Hash) && value['ports'].is_a?(Array)
                  value['ports']
                else
                  []
                end

        Container.new name, ports: ports
      end

      network = Network.new
      @containers.each { |container| network.connect container.id }

      @containers.each &:start
      at_exit { @containers.each &:destroy }
    end
  end
