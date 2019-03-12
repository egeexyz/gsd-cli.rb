require "colorize"

# Create a Rust server
class GameTemplate
  def initialize(game, path = "")
    @game = game
    @install_path = install_path(path)
    @file_path = "/tmp/#{@game.name}.service"
  end

  def start
    system("sudo -p 'sudo password: ' systemctl start #{@game.name}")
  end

  def restart
    system("sudo -p 'sudo password: ' systemctl restart #{@game.name}")
  end

  def status
    system("sudo -p 'sudo password: ' systemctl status #{@game.name}")
  end

  def stop
    system("sudo -p 'sudo password: ' systemctl stop #{@game.name}")
  end

  def enable
    system("sudo -p 'sudo password: ' systemctl enable #{@game.name}")
  end

  def disable
    system("sudo -p 'sudo password: ' systemctl disable #{@game.name}")
  end

  def run
    exec(@game.launch(@install_path))
  end

  def install(user = "anonymous")
    puts "Beginning installation process. This may take a while..."
    ensure_delete_unit_file()
    install_server(user)
    create_unit_file()
    system("sudo -p 'sudo password: ' cp -f #{@file_path} /etc/systemd/system/#{@game.name}.service")
    puts "Server installation & deployment complete!".green
  end

  private

  def install_server(user)
    system("/usr/games/steamcmd +login anonymous +quit")
    `/usr/games/steamcmd +login #{user} +force_install_dir #{@install_path} +app_update #{@game.app_id} validate +quit`
    @game.post_install(@install_path) if defined? @game.post_install
  end

  def install_path(path)
    if defined? path
      install_path = "/tmp/#{@game.name}"
      puts "Install path not defined: installing to /tmp/#{@game.name}".yellow
    else
      install_path = path
    end
    install_path
  end

  def ensure_delete_unit_file
    File.delete(@file_path) if File.file?(@file_path)
  end

  def create_unit_file
    out_file = File.new(@file_path, "w")
    out_file.puts(unit_file_contents()) # TODO: Pass in map with config
    out_file.close()
  end

  def unit_file_contents
    "[Unit]
    After=network.target
    Description=#{@desc}
    [Install]
    WantedBy=default.target
    [Service]
    LimitNPROC=infinity
    WorkingDirectory=#{Dir.pwd}
    Type=simple
    User=#{`whoami`}
    ExecStart=#{Dir.pwd}/bin/gsd run #{@game.name}"
  end
end
