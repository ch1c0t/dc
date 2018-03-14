def initialize name, directory: name
  @name = name
  @directory = directory
end

def exist?
  Docker::Image.exist? @name
end

def build
  image = Docker::Image.build_from_dir @directory do |json|
    puts JSON.parse json
  end
  image.tag repo: @name
  image
end
