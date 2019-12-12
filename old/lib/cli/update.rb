# frozen_string_literal: true

require "commander/import"
require "game_template"
require "cli/game_hash"
require "helpers"

command :update do |c|
  c.syntax = "gsd update [args] [options]"
  c.summary = "Updates an installed dedicated game server."
  c.description = "Updates an installed dedicated game server."
  c.option "--path OPTIONAL", String, "Path that the game server will be installed to."
  c.option "--steamuser OPTIONAL", String, "Steam user account required to install certain games."
  c.option "--steampassword OPTIONAL", String, "Steam account password for installing certain games."
  c.action do |args, options|
    game = game_hash[args.first()]
    abort("Non-Steam games not supported at this time 😞") if (game.app_id.nil?)
    update(game, options.path, options.steamuser, options.steampassword)
  end
end

# Update is functionally the same as install at this point because
# Servers installed via steamcmd are simply "reinstalled" to update them
# Non-steamcmd servers are not supported at this point (thats a 0.3.0 thing)
def update(game, path, steam_user, steam_password)
  puts "Beginning #{game.name} server update. This may take a while...".blue
  system("rm -f #{"/tmp/#{game.name}.service"}")
  system("rm -f /etc/systemd/system/#{game.name}.service")
  GameTemplate.new(game)
              .install(Helpers.get_install_path(path, game.name),
                      Helpers.get_steamcmd_login(steam_user, steam_password))
  puts "#{game.name} server update complete. Check the output for messages or warnings.".green
end