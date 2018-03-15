Gem::Specification.new do |g|
  g.name    = 'dc'
  g.files   = ['lib/dc.rb', 'bin/dc']
  g.version = '0.0.1'
  g.summary = 'Manage projects with Docker conveniently.'
  g.authors = ['Anatoly Chernow']

  g.add_dependency 'docker-api'

  g.executables << 'dc'
end
