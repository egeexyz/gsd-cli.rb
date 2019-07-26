# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name                     = "gsd-cli"
  s.version                  = "0.1.37"
  s.date                     = "2019-07-25"
  s.required_ruby_version    = ">= 2.5"
  s.summary                  = "A cli for launching servers"
  s.description              = "A simple cli for launching dedicated game servers"
  s.authors                  = ["Egee"]
  s.email                    = "brian@egee.io"
  s.files                    = Dir["bin/*"] + Dir["lib/*.rb"] + Dir["lib/*/*.rb"]
  s.homepage                 = "https://github.com/Egeeio/gsd-cli"
  s.license                  = "MIT"
  s.executables << "gsd-cli"
  s.add_runtime_dependency "colorize", "~> 0.8.1"
  s.add_runtime_dependency "commander", "~> 4.4"
end
