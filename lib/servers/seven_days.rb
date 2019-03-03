# Create a 7 Days to Die server
class SevenDays
  attr_reader :name
  def initialize(install_path = "")
    @name = "sdtd"
    @app_id = "294420"
    @install_path = "/tmp/#{@name}" if install_path.empty?
    @log_path = "#{@install_path}/console.log"
  end

  def install
    puts "Beginning installation process. This may take a while..."
    system("/usr/games/steamcmd +login anonymous +quit")
    `/usr/games/steamcmd +login anonymous +force_install_dir #{@install_path} +app_update #{@app_id} validate +quit`
    system("touch #{@log_path}")
    system("rm #{@install_path}/serverconfig.xml")
    system("rm #{@install_path}/startserver.sh")
    system("curl https://s3-us-west-2.amazonaws.com/gsd-sdtd/serverconfig.xml > #{@install_path}/serverconfig.xml")
    system("curl https://s3-us-west-2.amazonaws.com/gsd-sdtd/startserver.sh > #{@install_path}/startserver.sh")
    puts "Install complete."
  end

  def exec_start(map = "ctf_2fort", players = 24)
    "#{@install_path}/sdtd/server_files/startserver.sh -configfile=serverconfig.xml & /usr/bin/tail -f #{@log_path}"
  end
end
