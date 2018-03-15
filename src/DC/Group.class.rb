def initialize hash, directory:
  @hash = hash
  @images = hash.keys.map do |name|
    Image.new name, directory: "#{directory}/#{name}"
  end
end

attr_reader :images

def containers
  @containers ||= create_containers
end

def build_missing_images
  @images.each do |image|
    image.build unless image.exist?
  end
end

def start
  network = Network.new
  containers.each { |container| network.connect container.id }
  containers.each &:start
end

def destroy
  containers.each &:destroy
end

private
  def create_containers
    @hash.map do |name, value|
      ports = if value.is_a?(Hash) && value['ports'].is_a?(Array)
                value['ports']
              else
                []
              end

      Container.new name, ports: ports
    end
  end
