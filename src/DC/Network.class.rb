def initialize name = 'common'
  @network = prepare_network_with_name name
end

def internal_network
  @network
end

extend Forwardable
delegate [:id, :connect] => :internal_network

def name
  @network.info['Name']
end

private
  def prepare_network_with_name name
    Docker::Network.get name
  rescue Docker::Error::NotFoundError
    Docker::Network.create name
  end
