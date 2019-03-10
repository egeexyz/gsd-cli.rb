require "commander/import"
require "./lib/game_servers/rust"
require "./lib/game_template"

@games = {
  # "tf2" => TeamFortress.new,
  # "sdtd" => SevenDays.new,
  "rust" => Rust.new
}

program :name, "gsc-cli"
program :version, "0.1.0"
program :description, "A cli tool to manage dedicated game servers on Linux"

command :deploy do |c|
  c.syntax = "gsd deploy [args]"
  c.summary = "Install and deploy a dedicated game server as a daemon"
  c.description = "Install and deploy a dedicated game server as a daemon (systemd unit)."
  c.action do |args|
    GameTemplate.new(@games[args.first()]).deploy()
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

command :restart do |c|
  c.syntax = "gsc-cli start [options]"
  c.summary = "Starts a game server"
  c.description = "Start a game server"
  c.example "description", "command example"
  c.option "--some-switch", "Some switch that does something"
  c.action do |args, options|
    game = @games[args.first].restart()
  end
end

command :status do |c|
  c.syntax = "gsc-cli start [options]"
  c.summary = "Starts a game server"
  c.description = "Start a game server"
  c.example "description", "command example"
  c.option "--some-switch", "Some switch that does something"
  c.action do |args, options|
    game = @games[args.first].status()
  end
end

command :stop do |c|
  c.syntax = "gsc-cli start [options]"
  c.summary = "Starts a game server"
  c.description = "Start a game server"
  c.example "description", "command example"
  c.option "--some-switch", "Some switch that does something"
  c.action do |args, options|
    game = @games[args.first].stop()
  end
end

command :enable do |c|
  c.syntax = "gsc-cli start [options]"
  c.summary = "Starts a game server"
  c.description = "Start a game server"
  c.example "description", "command example"
  c.option "--some-switch", "Some switch that does something"
  c.action do |args, options|
    game = @games[args.first].stop()
  end
end

command :disable do |c|
  c.syntax = "gsc-cli start [options]"
  c.summary = "Starts a game server"
  c.description = "Start a game server"
  c.example "description", "command example"
  c.option "--some-switch", "Some switch that does something"
  c.action do |args, options|
    game = @games[args.first].stop()
  end
end
