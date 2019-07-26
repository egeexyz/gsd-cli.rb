# frozen_string_literal: true

require "commander/import"
require "game_template"
require "cli/game_hash"

command :run do |c|
  c.syntax = "gsd run [args]"
  c.summary = "Run an installed dedicated game server as a new process."
  c.description = "Runs an installed dedicated game server as a new process. This command is used by the daemon and is not designed to be run manually."
  c.option "--path STRING", String, "Path that the game server will be installed to."
  c.action do |args, options|
    GameTemplate.new(game_hash[args.first()]).run(options.path)
  end
end