#!/usr/bin/env ruby

require 'rubygems'
require 'commander/import'
require 'hyperkit'

program :name, 'gsc-cli'
program :version, '0.0.1'
program :description, 'A cli to manage gsc servers'

command :create do |c|
  c.syntax = 'gsc-cli create [options]'
  c.summary = ''
  c.description = ''
  c.example 'description', 'command example'
  c.option '--some-switch', 'Some switch that does something'
  c.action do |args, options|
    lxd = Hyperkit::Client.new(api_endpoint: 'https://127.0.0.1:8443', verify_ssl: false)
    lxd.create_container("test-container", alias: "ubuntu/trusty/amd64")
    # test = lxd.container('testing')
    # puts test
    lxd.copy_container('testing', 'testering')
    # lxd.stop_container 'testing'
    # lxd.delete_container 'testing'
  end
end

command :delete do |c|
  c.syntax = 'gsc-cli delete [options]'
  c.summary = ''
  c.description = ''
  c.example 'description', 'command example'
  c.option '--some-switch', 'Some switch that does something'
  c.action do |args, options|
    # Do something or c.when_called Gsc-cli::Commands::Create
    puts 'nahh'
  end
end

command :list do |c|
  c.syntax = 'gsc-cli list [options]'
  c.summary = ''
  c.description = ''
  c.example 'description', 'command example'
  c.option '--some-switch', 'Some switch that does something'
  c.action do |args, options|
    # Do something or c.when_called Gsc-cli::Commands::List
  end
end

command :exec do |c|
  c.syntax = 'gsc-cli exec [options]'
  c.summary = ''
  c.description = ''
  c.example 'description', 'command example'
  c.option '--some-switch', 'Some switch that does something'
  c.action do |args, options|
    # Do something or c.when_called Gsc-cli::Commands::Exec
  end
end
