# frozen_string_literal: true

require "commander/import"
require "game_template"
require "cli/game_hash"

command :update do |c|
  c.syntax = "gsd update [args] [options]"
  c.summary = "Updates an installed dedicated game server."
  c.description = "Updates an installed dedicated game server."
  c.option "--path OPTIONAL", String, "Path that the game server will be installed to."
  c.option "--steamuser OPTIONAL", String, "Steam user account required to install certain games."
  c.option "--steampassword OPTIONAL", String, "Steam account password for installing certain games."
  c.action do |args, options|
    GameTemplate.new(game_hash[args.first()], options.path).update(options.path)
  end
end