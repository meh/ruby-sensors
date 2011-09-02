Gem::Specification.new {|s|
  s.name         = 'sensors'
  s.version      = '0.0.1'
  s.author       = 'meh.'
  s.email        = 'meh@paranoici.org'
  s.homepage     = 'http://github.com/meh/ruby-sensors'
  s.platform     = Gem::Platform::RUBY
  s.summary      = 'Bindings and wrapper for libsensors'
  s.files        = Dir.glob('lib/**/*.rb')
  s.require_path = 'lib'

  s.add_dependency('ffi') unless defined?(RUBY_ENGINE) && RUBY_ENGINE == 'rbx'
}
