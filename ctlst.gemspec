Gem::Specification.new do |s|
  s.name        = 'ctlst'
  s.version     = '0.1.13'
  s.date        = '2018-08-26'
  s.summary     = 'A helper for React.js projects'
  s.description = "Ctlst (pronounced 'Catalyst') is a tool similar to the Rails CLI. It provides simple commands to build React project that takes advantage of clean architecture, test driven development and containerisation. This folder must be added to your PATH."
  s.authors     = ['Faissal Bensefia']
  s.email       = 'faissal@firemail.cc'
  s.files       = Dir['{lib}/**/*.rb', '{templates}/**/*', '*.md']
  s.executables = ['ctlst']
  s.homepage    = 'http://github.com/faissalMT/Ctlst'
  s.license     = 'GPL-3.0'
end
