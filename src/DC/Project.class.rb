def initialize directory: '.', docker_socket: 'tcp://127.0.0.1:2375'
  check_if_docker_is_available_at docker_socket

  @directory = File.expand_path directory
  @images_directory = "#{@directory}/.docker/images"
  @services_file = "#{@directory}/.docker/services.yml"
end

def run
  prepare_images
  prepare_services
end

private
  def check_if_docker_is_available_at docker_socket
    Docker.url = docker_socket
    Docker.version
  #rescue Excon::Error::Socket
  end

  def prepare_images
    if Dir.exist? @images_directory
      images = (Dir.entries(@images_directory) - ['.', '..']).map do |name|
        Image.new name, directory: "#{@images_directory}/#{name}"
      end

      images.each do |image|
        image.build unless image.exist?
      end
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
        
      hash.each do |name, value|
        if value.is_a?(Hash) && (ports = value['ports']) && ports.is_a?(Array)
        else
        end
      end
    end
  end
