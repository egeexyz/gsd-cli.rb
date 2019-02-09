#!/usr/bin/env ruby

require 'rubygems'
require 'commander/import'

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
    # Do something or c.when_called Gsc-cli::Commands::Create
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
