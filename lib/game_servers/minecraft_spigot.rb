# A class for Feed The Beast Minecraft Server
class MinecraftSpigot
  attr_reader :name, :app_id
  def initialize
    @name = "minecraft"
    @app_id = nil
  end

  def launch(install_path)
  end

  def install_server(install_path)
  end
end
