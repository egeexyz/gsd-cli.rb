#
class Daemonize
  def initialize(desc,game, user, exec_post, exec_start)
    @desc = desc
    @user = user
    @game = game
    @exec_post = exec_post
    @exec_start = exec_start
  end

  def it
    file_path = '/tmp/test.service'
    File.delete(file_path) if File.file?(file_path)
    out_file = File.new(file_path, 'w')
    out_file.puts(build_unit_file)
    out_file.close
    system("sudo -p 'sudo password: ' cp -f #{file_path} /etc/systemd/system/#{@game}.service")
  end

  # Just call systemctl from backticks



  def build_unit_file
    "[Unit]
    After=network.target
    Description=#{@desc}
    [Install]
    WantedBy=default.target
    [Service]
    Type=simple
    User=#{@user}
    ExecStartPost=#{@exec_post}
    ExecStart=#{@exec_start}"
  end
end
