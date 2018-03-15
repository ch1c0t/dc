require_relative 'helper'

describe 'basic project' do
  it do
    project = DC::Project.new directory: 'spec/projects/basic'
    project.run

    assert { Docker::Image.exist? 'a' }
    assert { Docker::Image.exist? 'e' }
  end

  after do
    Docker::Image.remove 'a'
    Docker::Image.remove 'e'
  end
end

describe 'project with bad image' do
  it do
    project = DC::Project.new directory: 'spec/projects/with_bad_image'
    expect { project.run }
      .to raise_error Docker::Error::UnexpectedResponseError
  end
end

describe 'project with interdependencies' do
  it do
    project = DC::Project.new directory: 'spec/projects/with_interdependencies'
    project.run

    assert { Docker::Image.exist? 'a' }
    assert { Docker::Image.exist? 'c' }
  end

  after do
    Docker::Image.remove 'a'
    Docker::Image.remove 'c'
  end
end
