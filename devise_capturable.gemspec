# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'devise_capturable/version'

Gem::Specification.new do |gem|
  gem.name          = "devise_capturable"
  gem.version       = Devise::Capturable::VERSION
  gem.authors       = ["Rune Skjoldborg Madsen"]
  gem.email         = ["rune@runemadsen.com"]
  gem.description   = %q{Devise::Capturable is a gem that makes it possible to use the Janrain Engage user registration widget, while preserving your Devise authentication setup with your custom user model.}
  gem.summary       = %q{Janrain Capture for Devise}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency("httparty")
  gem.add_development_dependency("devise")
  gem.add_development_dependency("rspec", "~> 2.14")
  gem.add_development_dependency("rails")

end
