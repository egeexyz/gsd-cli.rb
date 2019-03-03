require "commander/import"
require "./lib/deploy"
require "./lib/daemonize"
require "./lib/servers/team_fortress"
require "./lib/servers/seven_days.rb"

@games = {
  "tf2" => TeamFortress.new,
  "sdtd" => SevenDays.new
}

program :name, "gsc-cli"
program :version, "0.0.1"
program :description, "A cli to manage gsc servers"

command :deploy do |c|
  c.syntax = "gsc-cli deploy [options]"
  c.summary = "Deploy a game server as a systemd unit"
  c.description = "Deploy a game server as a systemd unit. The game server must be installed first"
  c.example "description", "command example"
  c.option "--some-switch", "Some switch that does something"
  c.action do |args, options|
    daemon = Daemonize.new(@games[args.first])
    daemon.build()
    Deploy.it(daemon)
  end
end

command :install do |c|
  c.syntax = "gsc-cli deploy [options]"
  c.summary = "Installs a game server onto the local file system"
  c.description = "Installs a game server onto the local file system"
  c.example "description", "command example"
  c.option "--some-switch", "Some switch that does something"
  c.action do |args, options|
    game = @games[args.first].install()
  end
end
