require_relative 'helper'

describe do
  it do
    project = DC::Project.new directory: 'spec/projects/basic'
    project.run

    assert { Docker::Image.exist? 'a' }
    assert { Docker::Image.exist? 'b' }
  end

  after do
    Docker::Image.remove 'a'
    Docker::Image.remove 'b'
  end
end
