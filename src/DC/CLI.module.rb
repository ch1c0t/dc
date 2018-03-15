def self.run
  project = Project.new

  if ARGV.empty?
    project.run
  else
    case ARGV.size
    when 1
      case ARGV.first
      when 'stop'
        project.group.stop
      when 'restart'
        project.group.stop
        project.group.start
      when 'rs'
        project.group.stop
        project.group.rebuild_images
        project.group.start
      when 'ri'
        project.rebuild_images
      end
    when 2
      case ARGV
      when ['rebuild', 'services']
        project.group.stop
        project.group.rebuild_images
        project.group.start
      when ['rebuild', 'images']
        project.rebuild_images
      end
    end
  end
end
