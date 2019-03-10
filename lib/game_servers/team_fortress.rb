# A module to produce resources for a Team Fortress 2 server
class TeamFortress
  attr_reader :name, :app_id
  def initialize
    @name = "tf2"
    @app_id = "232250"
  end

  def launch(install_path, map = "ctf_2fort", players = 24)
    "cd #{install_path} &&
    #{install_path}/tf/srcds_run \
    -console \
    -game tf \
    +sv_pure 1 \
    +map #{map} \
    +maxplayers #{players} \
    -condebug & \
    /usr/bin/tail -f #{install_path}/server.log"
  end
end
