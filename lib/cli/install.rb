# frozen_string_literal: true

require "commander/import"
require "game_template"
require "cli/game_hash"
require "helpers"

command :install do |c|
  c.syntax = "gsd install [args] [options]"
  c.summary = "Install and deploy a dedicated game server as a daemon."
  c.description = "Installs and deploy a dedicated game server as a daemon (systemd unit)."
  c.option "--path OPTIONAL", String, "Path that the game server will be installed to."
  c.option "--steamuser OPTIONAL", String, "Steam user account required to install certain games."
  c.option "--steampassword OPTIONAL", String, "Steam account password for installing certain games."
  c.action do |args, options|
    abort("Install what? Provide a game name argument!") if (args.first().nil?)
    install(game_hash[args.first()], options.path, options.steamuser, options.steampassword)
    end
end

def install(game, path, steam_user, steam_password)
  puts "Beginning installation process. This may take a while...".blue
  install_path = if path.nil?
                   puts "Install path was not provided: defaulting to /opt/#{game.name}".yellow
                  "/opt/#{game.name}"
                else
                  path
                end
  steam_login = if steam_user.nil?
                "+login anonymous"
                else
                  "+login #{steam_user} #{steam_password}"
                end
  system("rm -f #{"/tmp/#{game.name}.service"}")
  system("rm -f /etc/systemd/system/#{game.name}.service")
  GameTemplate.new(game)
              .install(Helpers.get_install_path(path, game.name),
                       Helpers.get_steamcmd_login(steam_user, steam_password))
  puts "Server installation complete. Check the output for messages or warnings.".green
end
