class << self
  def all
    @all ||= {}
  end

  def [] name
    all[name]
  end

  def []= name, image
    all[name] = image
  end
end

def initialize name, directory: name
  @name = name
  @directory = directory
  self.class[name] = self
end

attr_reader :name

def exist?
  Docker::Image.exist? @name
end

def build
  build_parent_image_if_available
  image = Docker::Image.build_from_dir @directory do |json|
    puts JSON.parse json
  end
  image.tag repo: @name
  image
end

private
  def build_parent_image_if_available
    dockerfile = IO.read "#{@directory}/Dockerfile"
    from, image_name = dockerfile.each_line.first.split ' '
    fail from unless from == 'FROM'

    if image = self.class[image_name]
      unless image.exist?
        puts "Building parent image #{image.name}."
        image.build
      end
    end
  end
