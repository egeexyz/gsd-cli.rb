require "commander/import"
require "./lib/game_template"
require "./lib/game_servers/gmod"
require "./lib/game_servers/rust"
require "./lib/game_servers/starbound"
require "./lib/game_servers/seven_days"
require "./lib/game_servers/team_fortress"

def userdata
  {
    "starbound" => Starbound.new,
    "tf2" => TeamFortress.new,
    "sdtd" => SevenDays.new,
    "gmod" => GarrysMod.new,
    "rust" => Rust.new
  }
end

@games = userdata

program :name, "gsc-cli"
program :version, "0.1.0"
program :description, "A cli tool to manage dedicated game servers on Linux"

command :install do |c|
  c.syntax = "gsd install [args] [options]"
  c.summary = "Install and deploy a dedicated game server as a daemon."
  c.description = "Installs and deploy a dedicated game server as a daemon (systemd unit)."
  c.option "--user STRING", String, "User that the game server will run as."
  c.option "--install STRING", String, "Path that the game server will be installed to."
  c.action do |args, options|
    GameTemplate.new(@games[args.first()], options.install).install(options.user)
  end
end

command :run do |c|
  c.syntax = "gsd run [args]"
  c.summary = "Run an installed dedicated game server as a new process."
  c.description = "Runs an installed dedicated game server as a new process. This command is used by the daemon and is not designed to be run manually."
  c.action do |args|
    GameTemplate.new(@games[args.first()], args.last()).run()
  end
end

command :start do |c|
  c.syntax = "gsd start [args]"
  c.summary = "Start a installed dedicated game server."
  c.description = "Starts a dedicated game server daemon that has already been installed to the system."
  c.action do |args|
    GameTemplate.new(@games[args.first()], args.last()).start()
  end
end

command :restart do |c|
  c.syntax = "gsd restart [args]"
  c.summary = "Restart a installed dedicated game server."
  c.description = "Restarts a dedicated game server daemon that has already been installed to the system."
  c.action do |args|
    GameTemplate.new(@games[args.first()], args.last()).restart()
  end
end

command :status do |c|
  c.syntax = "gsd status [args]"
  c.summary = "Display the status of a installed dedicated game server."
  c.description = "Requests and returns the status of a installed dedicated game server from systemd."
  c.action do |args|
    GameTemplate.new(@games[args.first()], args.last()).status()
  end
end

command :stop do |c|
  c.syntax = "gsd stop [args]"
  c.summary = "Stop running dedicated game server."
  c.description = "Stops a running dedicated game server daemon."
  c.action do |args|
    GameTemplate.new(@games[args.first()], args.last()).stop()
  end
end

command :enable do |c|
  c.syntax = "gsd enable [args]"
  c.summary = "Force a dedicated game server daemon to launch at system start."
  c.description = "Enables a dedicated game server daemon to start when the system starts."
  c.action do |args|
    GameTemplate.new(@games[args.first()], args.last()).stop()
  end
end

command :disable do |c|
  c.syntax = "gsd disable [args]"
  c.summary = "Disable a dedicated game server daemon from starting at system start."
  c.description = "Disables a dedicated game server daemon from starting when the system starts."
  c.action do |args|
    GameTemplate.new(@games[args.first()], args.last()).stop()
  end
end
