def self.run
  project = Project.new

  if ARGV.empty?
    project.run
  else
    case ARGV.size
    when 1
      case ARGV.first
      when 'rs'
      when 'ri'
        project.rebuild_images
      end
    when 2
      case ARGV
      when ['rebuild', 'services']
      when ['rebuild', 'images']
        project.rebuild_images
      end
    end
  end
end
