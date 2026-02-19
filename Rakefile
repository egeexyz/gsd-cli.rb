# frozen_string_literal: true

require 'English'

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:rspec) do |t|
    t.pattern = 'spec/**/*_spec.rb'
    t.rspec_opts = '--format documentation --color'
  end
rescue LoadError
  task :rspec do
    puts 'RSpec is not installed. Run: bundle install'
    exit 1
  end
end

desc 'Run all tests and linting'
task test: %i[lint rspec]
task spec: :test
task default: :test

# ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈
# VERSION MANAGEMENT
# ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈
GEMSPEC_FILE = 'gsd-cli.gemspec'

def current_version
  File.read(GEMSPEC_FILE).match(/s\.version\s*=\s*'(\d+\.\d+\.\d+)'/)[1]
end

def write_version(new_version)
  content = File.read(GEMSPEC_FILE)
  updated = content.sub(/s\.version\s*=\s*'\d+\.\d+\.\d+'/, "s.version                  = '#{new_version}'")
  File.write(GEMSPEC_FILE, updated)
end

desc 'Display current version'
task :version do
  puts "gsd-cli v#{current_version}"
end

desc 'Increment the patch version'
task :bump do
  major, minor, patch = current_version.split('.').map(&:to_i)
  new_version = "#{major}.#{minor}.#{patch + 1}"
  write_version(new_version)
  puts "Bumped version: #{current_version}"
end

namespace :bump do
  desc 'Increment the minor version'
  task :minor do
    major, minor, _patch = current_version.split('.').map(&:to_i)
    new_version = "#{major}.#{minor + 1}.0"
    write_version(new_version)
    puts "Bumped version: #{current_version}"
  end

  desc 'Increment the major version'
  task :major do
    major, _minor, _patch = current_version.split('.').map(&:to_i)
    new_version = "#{major + 1}.0.0"
    write_version(new_version)
    puts "Bumped version: #{current_version}"
  end
end

desc 'Release: lint, test, bump patch, and git tag'
task :release, [:level] => %i[lint test] do |_t, args|
  level = args[:level] || 'patch'
  old_version = current_version

  case level
  when 'major'
    Rake::Task['bump:major'].invoke
  when 'minor'
    Rake::Task['bump:minor'].invoke
  else
    Rake::Task['bump'].invoke
  end

  new_version = current_version
  puts "\nReleased: v#{old_version} -> v#{new_version}"
  puts "Run: git add #{GEMSPEC_FILE} && git commit -m 'Release v#{new_version}' && git tag v#{new_version}"
end

# ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈
# LINTING
# ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈
desc 'Lint Ruby files for syntax errors'
task :lint do # rubocop:disable Metrics/BlockLength
  errors = []

  puts 'Checking Ruby syntax...'
  ruby_files = Dir.glob('lib/**/*.rb') + Dir.glob('spec/**/*.rb') + Dir.glob('bin/*')
  ruby_files.each do |file|
    output = `ruby -c #{file} 2>&1`
    if $CHILD_STATUS.success?
      puts "  ✓ #{file}"
    else
      errors << "Ruby syntax error in #{file}:\n#{output}"
    end
  end

  unless ENV['SKIP_RUBOCOP']
    puts "\nRunning RuboCop..."
    rubocop_result = system('bundle exec rubocop')
    errors << 'RuboCop found style violations' unless rubocop_result
  end

  puts "\n#{'≈' * 60}"
  if errors.any?
    puts 'LINT FAILURES'
    puts '≈' * 60
    errors.each { |e| puts "\n#{e}" }
    puts "\n#{'≈' * 60}"
    abort "Linting failed with #{errors.size} error(s)"
  else
    puts "✓ All files passed linting (#{ruby_files.size} Ruby)"
    puts '≈' * 60
  end
end

# ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈
# BUILD
# ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈
desc 'Build the gem'
task :build do
  system('gem build gsd-cli.gemspec')
end
