require "colorize"

# Create a Rust server
class GameTemplate
  def initialize(game, path = "")
    @game = game
    @install_path = install_path(path)
    @file_path = "/tmp/#{@game.name}.service"
  end

  # TODO: This solution "works" in that it forks a new sub process but...
  # It leaves a dangling Ruby process running
  # When the terminal is closed, it deletes stdout (1) from /proc/
  def start
    pid = fork do
      `#{@game.bootstrap()}`
    end
    Process.detach(pid)
  end

  def run
    pid = spawn(@game.launch(@install_path))
    Process.detach(pid)
  end

  def deploy
    puts "Beginning deployment process. This may take a while..."
    install()
    ensure_delete_unit_file()
    create_unit_file()
    system("sudo -p 'sudo password: ' cp -f #{@file_path} /etc/systemd/system/#{@game.name}.service")
    puts "Deployment complete!".green
  end

  def install
    @log_path = "#{@install_path}/server.log" # TODO: This won't scale
    system("/usr/games/steamcmd +login anonymous +quit")
    `/usr/games/steamcmd +login anonymous +force_install_dir #{@install_path} +app_update #{@game.app_id} validate +quit`
    system("touch #{@log_path}")
  end

  def install_path(path = "")
    if path.empty?
      install_path = "/tmp/#{@game.name}"
      puts "Install path not defined: installing to /tmp/#{@game.name}".yellow
    else
      install_path = path
    end
    install_path
  end

  private

  def ensure_delete_unit_file
    File.delete(@file_path) if File.file?(@file_path)
  end

  def create_unit_file
    out_file = File.new(@file_path, "w")
    out_file.puts(@game.unit_file_contents()) # TODO: Pass in map with config
    out_file.close()
  end
end
