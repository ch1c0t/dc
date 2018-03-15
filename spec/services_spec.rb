require_relative 'helper'

describe do
  it 'builds images for services' do
    project = DC::Project.new directory: 'spec/projects/with_one_service'
    project.run

    assert { Docker::Image.exist? 'some_service' }
    Docker::Image.remove 'some_service'
  end

  it do
    project = DC::Project.new directory: 'spec/projects/basic_services'
    project.run

    assert { Docker::Image.exist? 'hobby' }
    assert { Docker::Image.exist? 'first' }
    assert { Docker::Image.exist? 'second' }
    assert { Docker::Image.exist? 'proxy' }
  end
end
