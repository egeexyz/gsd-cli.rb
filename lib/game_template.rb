# frozen_string_literal: true

require "colorize"
require "helpers"

# Create a Rust server
class GameTemplate
  def initialize(game, remote = "")
    @game = game
    @remote = remote
  end

  def start
    system("sudo -p 'sudo password: ' systemctl start #{@game.name}")
  end

  def restart
    command = "systemctl restart #{@game.name}"
    if @remote.nil?
      system("sudo -p 'sudo password: ' #{command}")
    else
      puts @remote
      puts command
      Helpers.remote_cmd(@remote, command)
    end
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

  def run(install_path)
    exec(@game.launch(install_path))
  end

  def install(install_path, steam_login)
    if @game.app_id.nil?
      @game.install_server(install_path)
    else
      install_steam_server(install_path, steam_login)
    end
    @game.post_install(install_path) if defined? @game.post_install
    create_unit_file(install_path)
  end

  def update(install_path)
    if @game.app_id.nil?
      puts "Non-Steam games not supported."
    else
      install_steam_server(install_path)
    end
  end

  private

  # Installs or Updates a dedicated game server via Steamcmd
  def install_steam_server(install_path, steam_login)
    abort("STEAMCMD does not appear to be installed! Aborting...".red) if `which steamcmd`.empty?
    system("$(which steamcmd) #{steam_login} +quit")
    system("$(which steamcmd) #{steam_login} +force_install_dir #{install_path} +app_update #{@game.app_id} validate +quit")
  end

  def create_unit_file(install_path)
    file_path = "/tmp/#{@game.name}.service"
    `touch #{file_path}`
    `echo "#{unit_file_contents(install_path)}" >> #{file_path}`
    system("mv -f #{"/tmp/#{@game.name}.service"} /etc/systemd/system/#{@game.name}.service")
  end

  def unit_file_contents(install_path)
    "[Unit]
    After=network.target
    Description=Daemon for #{@game.name} dedicated server
    [Install]
    WantedBy=default.target
    [Service]
    Type=simple
    ExecStart=#{`which gsd-cli`.strip()} run #{@game.name} --path #{install_path}"
  end
end
