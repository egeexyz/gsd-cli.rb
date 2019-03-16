# A class for Feed The Beast Minecraft Server
class Minecraft
  attr_reader :name, :app_id
  def initialize
    @name = "minecraft"
    @app_id = "feed_the_beast"
  end

  def launch(install_path)
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

  def install(install_path)
    system("wget https://media.forgecdn.net/files/2516/475/FTBRevelationServer_1.2.0.zip -O /tmp/server.zip")
    system("unzip /tmp/server.zip #{install_path}")
    system("echo eula=false > #{install_path}/eula.txt")
  end
end
