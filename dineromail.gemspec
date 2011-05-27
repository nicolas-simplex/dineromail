# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "dineromail/version"

Gem::Specification.new do |s|
  s.name        = "dineromail"
  s.version     = Dineromail::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nicolas Mosconi"]
  s.email       = ["nicolas@soluciones-simplex.com.ar"]
  s.homepage    = ""
  s.summary     = %q{Dineromail library for Rails}
  s.description = %q{Integration with dineromail plataform for rails proyects}
  
  s.add_dependency "xml-simple"
  s.add_dependency "httparty"
  s.add_development_dependency "bundler"
  s.add_development_dependency "rspec"
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
