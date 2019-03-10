# A module to produce resources for a Team Fortress 2 server
class TeamFortress
  attr_reader :name
  def initialize(install_path = "")
    @name = "tf2"
    @app_id = "232250"
    @install_path = "/tmp/#{@name}" if install_path.empty?
    @log_path = "#{@install_path}/tf/console.log"
  end

  def install
    puts "Beginning installation process. This may take a while..."
    system("/usr/games/steamcmd +login anonymous +quit")
    `/usr/games/steamcmd +login anonymous +force_install_dir #{@install_path} +app_update #{@app_id} validate +quit`
    system("touch #{@log_path}")
    puts "Install complete."
  end

  def exec_start(map = "ctf_2fort", players = 24)
    "#{@install_path}/tf/srcds_run \
    -console \
    -game tf \
    +sv_pure 1 \
    +map #{map} \
    +maxplayers #{players} \
    -condebug & \
    /usr/bin/tail -f #{@log_path}"
  end
end
