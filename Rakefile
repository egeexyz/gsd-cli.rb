require "rake/clean"

task :run do
  ARGV.each { |a| task a.to_sym do ; end }
  sh "./bin/gsd-cli #{ARGV[1..-1].join(' ')}"
end

task :build do
  sh "gem build gsd-cli.gemspec"
end

task :push do
  sh "gem push gsd-cli-0.1.*.gem"
end

task :clean do
  sh "rm -r gsd-cli*.gem"
end

task default: :run
