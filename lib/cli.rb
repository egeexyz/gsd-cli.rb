require "commander/import"
require "./lib/game_servers/rust"
require "./lib/game_template"

@games = {
  # "tf2" => TeamFortress.new,
  # "sdtd" => SevenDays.new,
  "rust" => Rust.new
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
    game = GameTemplate.new(@games[args.first()])
    game.install()
    game.deploy()
  end
end

command :run do |c|
  c.syntax = "gsc-cli start [options]"
  c.summary = "Starts a game server"
  c.description = "Start a game server"
  c.example "description", "command example"
  c.option "--some-switch", "Some switch that does something"
  c.action do |args, options|
    GameTemplate.new(@games[args.first()]).run()
  end
end

command :start do |c|
  c.syntax = "gsc-cli start [options]"
  c.summary = "Starts a game server"
  c.description = "Start a game server"
  c.example "description", "command example"
  c.option "--some-switch", "Some switch that does something"
  c.action do |args, options|
    game = @games[args.first].start()
  end
end
