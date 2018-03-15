require_relative 'helper'

describe do
  it 'builds images for services' do
    project = DC::Project.new directory: 'spec/projects/with_one_service'
    project.run

    assert { Docker::Image.exist? 'some_service' }
    Docker::Image.remove 'some_service'
  end

  it 'starts services' do
    project = DC::Project.new directory: 'spec/projects/basic_services'
    project.run
    
    assert { project.containers.size == 3 }
    assert { Docker::Container.all.size == 3 }
    assert { project.containers.map(&:name) == ['first', 'second', 'proxy'] }
  end
end
