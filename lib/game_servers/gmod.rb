# A module to produce resources for a Garry's Mod server
class GarrysMod
  attr_reader :name, :app_id
  def initialize
    @name = "gmod"
    @app_id = "4020"
  end

  def launch(install_path, map = "gm_construct", players = 16, collection_id = "776121544")
    "cd #{install_path} &&
    #{install_path}/srcds_run \
    -console \
    -game garrysmod \
    +map #{map} \
    +maxplayers #{players} \
    +host_workshop_collection #{collection_id} \
    -condebug & \
    /usr/bin/tail -f #{install_path}/garrysmod/console.log"
  end

  def post_install(install_path)
    system("touch #{install_path}/garrysmod/console.log")
  end
end
