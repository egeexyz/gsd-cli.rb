require "rake/clean"

task :build do
  sh "gem build gsd-cli.gemspec"
end

task :clean do
  sh "rm -r gsd-cli*.gem"
end

task :push do
  sh "gem push gsd-cli-0.1.*.gem"
end

task :run do
  ARGV.each { |a| task a.to_sym do ; end }
  sh "./bin/gsd-cli #{ARGV[1..-1].join(' ')}"
end

task :test do
  sh "rspec"
end
