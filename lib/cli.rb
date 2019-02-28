require "commander/import"
require "./lib/deploy"
require "./lib/daemonize"
require "./lib/servers/team_fortress"

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
    tf2_daemon = Daemonize.new("test",
                               "tf2",
                               "ubuntu",
                               TeamFortress.exec_start())
    Deploy.it(args.first, tf2_daemon.build())
  end
end

command :build do |c|
  c.syntax = "gsc-cli build [options]"
  c.summary = "Build a systemd unit"
  c.description = "Build Description"
  c.example "description", "command example"
  c.option "--some-switch", "Some switch that does something"
  c.action do |args, options|
    desc = "test desc"
    game = "tf2"
    user = "ubuntu"
    exec_start = "/tmp/gsd/tf2/server_files/srcds_run \
    -console \
    -game tf \
    +sv_pure 1 \
    +map ctf_2fort \
    +maxplayers 24 \
    -condebug & \
    /usr/bin/tail -f /tmp/gsd/tf2/server_files/tf/console.log"

    daemonize = Daemonize.new(desc, game, user, exec_post, exec_start)
    daemonize.it
  end
end
