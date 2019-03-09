# Utility class that creates the systemd unit file (the daemon)
class Daemonize
  attr_reader :game, :file_path
  def initialize(game,
                 desc = "MissingDescription",
                 user = "ubuntu")
    abort("Error: daemonize what game?") if game.exec_start.nil?
    @desc = desc
    @user = user
    @game = game.name
    @env_vars = game.env_vars
    @exec_start = game.exec_start
    @install_path = game.install_path
    @file_path = "/tmp/#{@game}.service"
  end

  def build
    ensure_delete_unit_file()
    create_unit_file()
  end

  private

  def create_unit_file
    out_file = File.new(@file_path, "w")
    out_file.puts(build_unit_file())
    out_file.close
  end

  def ensure_delete_unit_file
    File.delete(@file_path) if File.file?(@file_path)
  end

  def build_unit_file
    "[Unit]
    After=network.target
    Description=#{@desc}
    [Install]
    WantedBy=default.target
    [Service]
    Environment=#{@env_vars}
    WorkingDirectory=#{Dir.pwd}
    Type=forking
    User=#{@user}
    ExecStart=#{@exec_start}"
  end
end
