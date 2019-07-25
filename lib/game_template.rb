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

  def install(install_path, steamuser, steampassword)
    # ensure_delete_unit_file(install_path) if install_path.nil? == false
    if @game.app_id.nil?
      @game.install_server(get_install_path(install_path))
    else
      install_steam_server(install_path, steamuser, steampassword)
    end
    @game.post_install(install_path) if defined? @game.post_install
    cli_path = `which gsd-cli`.strip()
    create_unit_file(cli_path, install_path)
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
  def install_steam_server(install_path = "/opt/#{@game.name}", steamuser = nil, steampassword = nil)
    login = if steamuser.nil?
              "+login anonymous"
            else
              "+login #{steamuser} #{steampassword}"
            end
    abort("STEAMCMD does not appear to be installed! Aborting...".red) if `which steamcmd`.empty?
    system("$(which steamcmd) +login anonymous +quit")
    system("$(which steamcmd) #{login} +force_install_dir #{install_path} +app_update #{@game.app_id} validate +quit")
    # @game.post_install(install_path) if defined? @game.post_install
  end

  def get_install_path(path)
    install_path = if path.nil?
                     #  puts "Install path not defined: installing to /tmp/#{@game.name}".yellow
                     "/opt/#{@game.name}"
                   else
                     path
                   end
    install_path
  end

  def ensure_delete_unit_file(unit_file_path)
    File.delete(unit_file_path) if File.file?(unit_file_path)
  end

  def create_unit_file(cli_path, install_path)
    file_path = "/tmp/#{@game.name}.service"
    out_file = File.new(file_path, "w")
    out_file.puts(unit_file_contents(cli_path, install_path)) # TODO: Pass in map with config
    out_file.close()
    system("mv -f #{"/tmp/#{@game.name}.service"} /etc/systemd/system/#{@game.name}.service")
  end

  def unit_file_contents(cli_path, install_path)
    "[Unit]
    After=network.target
    Description=#{@desc}
    [Install]
    WantedBy=default.target
    [Service]
    Type=simple
    ExecStart=#{cli_path} run #{@game.name} --path #{install_path}"
  end
end
