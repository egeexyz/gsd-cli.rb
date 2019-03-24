require "colorize"

# Create a Rust server
class GameTemplate
  def initialize(game, path = nil)
    @game = game
    @install_path = get_install_path(path)
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

  def install(steamuser, steampassword)
    puts "Beginning installation process. This may take a while..."
    ensure_delete_unit_file()
    if @game.app_id.nil?
      @game.install_server(@install_path)
    else
      install_steam_server(steamuser, steampassword)
    end
    create_unit_file()
    system("sudo -p 'sudo password: ' cp -f #{@file_path} /etc/systemd/system/#{@game.name}.service")
    puts "Server installation & deployment complete!".green
  end

  # Generic cli-facing update function
  # for updating installed dedicated game servers
  def update
    if @game.app_id.nil?
      puts "Non-Steam games not supported."
    else
      install_steam_server()
    end
  end

  private

  # Installs or Updates a dedicated game server via Steamcmd
  def install_steam_server(steamuser = nil, steampassword = nil)
    login = if steamuser.nil?
              "+login anonymous"
            else
              "+login #{steamuser} #{steampassword}"
            end
    system("/usr/games/steamcmd +login anonymous +quit")
    system("/usr/games/steamcmd #{login} +force_install_dir #{@install_path} +app_update #{@game.app_id} validate +quit")
    @game.post_install(@install_path) if defined? @game.post_install
  end

  def get_install_path(path)
    install_path = if path.nil?
                    #  puts "Install path not defined: installing to /tmp/#{@game.name}".yellow
                     "/tmp/#{@game.name}"
                   else
                     path
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
    ExecStart=#{Dir.pwd}/bin/gsd run #{@game.name} --path #{@install_path}"
  end
end
