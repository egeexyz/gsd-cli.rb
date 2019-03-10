require "colorize"

# Utility class that creates the systemd unit file (the daemon)
class Daemonize
  def initialize(game)
    @game = game
    @file_path = "/tmp/#{@game.name}.service"
  end
end
