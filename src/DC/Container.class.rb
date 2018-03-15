def initialize name, ports: []
  @name = name
  @container = if ports.empty?
    Docker::Container.create name: name, Image: name
  else
    port_maps = ports.map do |port|
      if port.is_a? PortMap
        port
      else
        to, from = port.split ':'
        PortMap.new from: from, to: to
      end
    end

    Docker::Container.create(
      name: name, Image: name,
      ExposedPorts: port_maps.map do |map|
        ["#{map.internal_port}/tcp", {}]
      end.to_h,
      HostConfig: {
        PortBindings: port_maps.map do |map|
          array = [{ HostPort: map.external_port, HostIp: map.external_ip }]
          ["#{map.internal_port}/tcp", array]
        end.to_h
      }
    )
  end
end

attr_reader :name

def internal_container
  @container
end

extend Forwardable
delegate [:id, :start, :kill!, :remove] => :internal_container

def destroy
  kill!.remove
end

class PortMap
  def initialize from:, to:, external_ip: '0.0.0.0'
    @internal_port = from.to_s
    @external_port = to.to_s
    @external_ip = external_ip
  end

  attr_reader :internal_port, :external_port, :external_ip
end
