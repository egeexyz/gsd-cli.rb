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

task :help do
  sh "./bin/gsd-cli help"
end

task :install do
  ARGV.each { |a| task a.to_sym do ; end }
  sh "./bin/gsd-cli install #{ARGV[1..-1].join(' ')}"
end

task :start do
  ARGV.each { |a| task a.to_sym do ; end }
  sh "./bin/gsd-cli start #{ARGV[1..-1].join(' ')}"
end

task :restart do
  ARGV.each { |a| task a.to_sym do ; end }
  sh "./bin/gsd-cli restart #{ARGV[1..-1].join(' ')}"
end

task :stop do
  ARGV.each { |a| task a.to_sym do ; end }
  sh "./bin/gsd-cli stop #{ARGV[1..-1].join(' ')}"
end

task :uninstall do
  ARGV.each { |a| task a.to_sym do ; end }
  sh "./bin/gsd-cli restart #{ARGV[1..-1].join(' ')}"
end

task :list do
  sh "./bin/gsd-cli stop #{ARGV[1..-1].join(' ')}"
end

task :test do
  sh "rspec"
end
