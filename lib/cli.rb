require "commander/import"
require "./lib/deploy"
require "./lib/daemonize"
require "./lib/servers/team_fortress"
require "./lib/servers"

@game = {
  "tf2" => TeamFortress.new
}

program :name, "gsc-cli"
program :version, "0.0.1"
program :description, "A cli to manage gsc servers"

command :deploy do |c|
  c.syntax = "gsc-cli deploy [options]"
  c.summary = "Deploy a game server as a systemd unit"
  c.description = "Deploy Description"
  c.example "description", "command example"
  c.option "--some-switch", "Some switch that does something"
  c.action do |args, options|
    daemon = Daemonize.new(@game[args.first])
    daemon.build()
    Deploy.it(daemon)
  end
end
