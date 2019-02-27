#
class Daemonize
  def initialize(exec_start = nil,
                 game = "tf2",
                 desc = "Description",
                 user = "ubuntu")
    abort("Error: daemonize what game?") if exec_start.nil?
    @exec_start = exec_start
    @file_path = "/tmp/#{game}.service"
    @desc = desc
    @user = user
    @game = game
  end

  def build()
    ensure_delete_unit_file()
    create_unit_file()
    # system("sudo -p "sudo password: " cp -f #{file_path} /etc/systemd/system/#{@game}.service")
  end

  private

  def create_unit_file()
    out_file = File.new(@file_path, "w")
    out_file.puts(build_unit_file())
    out_file.close
  end

  def ensure_delete_unit_file()
    File.delete(@file_path) if File.file?(@file_path)
  end

  def build_unit_file
    "[Unit]
    After=network.target
    Description=#{@desc}
    [Install]
    WantedBy=default.target
    [Service]
    Type=simple
    User=#{@user}
    ExecStart=#{@exec_start}"
  end
end
