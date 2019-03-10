require "commander/import"
require "./lib/game_template"
require "./lib/game_servers/rust"
require "./lib/game_servers/seven_days"
require "./lib/game_servers/team_fortress"

@games = {
  "tf2" => TeamFortress.new,
  "sdtd" => SevenDays.new,
  "rust" => Rust.new
}

program :name, "gsc-cli"
program :version, "0.1.0"
program :description, "A cli tool to manage dedicated game servers on Linux"

command :install do |c|
  c.syntax = "gsd install [args]"
  c.summary = "Install and deploy a dedicated game server as a daemon."
  c.description = "Installs and deploy a dedicated game server as a daemon (systemd unit)."
  c.action do |args|
    GameTemplate.new(@games[args.first()]).install()
  end
end

command :run do |c|
  c.syntax = "gsd run [args]"
  c.summary = "Run an installed dedicated game server as a new process."
  c.description = "Runs an installed dedicated game server as a new process. This command is used by the daemon and is not designed to be run manually."
  c.action do |args|
    GameTemplate.new(@games[args.first()]).run()
  end
end

command :start do |c|
  c.syntax = "gsd start [args]"
  c.summary = "Start a installed dedicated game server."
  c.description = "Starts a dedicated game server daemon that has already been installed to the system."
  c.action do |args|
    GameTemplate.new(@games[args.first()]).start()
  end
end

command :restart do |c|
  c.syntax = "gsd restart [args]"
  c.summary = "Restart a installed dedicated game server."
  c.description = "Restarts a dedicated game server daemon that has already been installed to the system."
  c.action do |args|
    GameTemplate.new(@games[args.first()]).restart()
  end
end

command :status do |c|
  c.syntax = "gsd status [args]"
  c.summary = "Display the status of a installed dedicated game server."
  c.description = "Requests and returns the status of a installed dedicated game server from systemd."
  c.action do |args|
    GameTemplate.new(@games[args.first()]).status()
  end
end

command :stop do |c|
  c.syntax = "gsd stop [args]"
  c.summary = "Stop running dedicated game server."
  c.description = "Stops a running dedicated game server daemon."
  c.action do |args|
    GameTemplate.new(@games[args.first()]).stop()
  end
end

command :enable do |c|
  c.syntax = "gsd enable [args]"
  c.summary = "Force a dedicated game server daemon to launch at system start."
  c.description = "Enables a dedicated game server daemon to start when the system starts."
  c.action do |args|
    GameTemplate.new(@games[args.first()]).stop()
  end
end

command :disable do |c|
  c.syntax = "gsd disable [args]"
  c.summary = "Disable a dedicated game server daemon from starting at system start."
  c.description = "Disables a dedicated game server daemon from starting when the system starts."
  c.action do |args|
    GameTemplate.new(@games[args.first()]).stop()
  end
end
