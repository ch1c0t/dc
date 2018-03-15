if ARGV.empty?
  Project.new.run
else
  case ARGV.size
  when 1
    case ARGV.first
    when 'rs'
    when 'ri'
    end
  when 2
    case ARGV
    when ['rebuild', 'services']
    when ['rebuild', 'images']
    end
  end
end