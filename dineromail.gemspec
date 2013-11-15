# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "dineromail/version"

Gem::Specification.new do |s|
  s.name        = "dineromail"
  s.version     = Dineromail::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nicolas Mosconi", "Shadi Calcagni", "Juan Pablo Gutierrez"]
  s.email       = ["nicolas@soluciones-simplex.com.ar", "shadi@soluciones-simplex.com.ar", "juanpablo@soluciones-simplex.com.ar"]
  s.homepage    = ""
  s.summary     = %q{Dineromail library for Rails}
  s.description = %q{Integration with dineromail plataform for rails projects}

  s.add_dependency "happymapper", ["~> 0.4.0"]
  s.add_dependency "httparty"
  s.add_dependency "rails", [">= 3.0"]
  s.add_development_dependency "bundler"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "rspec2-rails-views-matchers"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
