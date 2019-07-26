# frozen_string_literal: true

require "open-uri"
require "fileutils"

# A class for Feed The Beast Minecraft Server
class MinecraftSpigot
  attr_reader :name, :app_id
  def initialize
    @name = "minecraft"
    @app_id = nil
    @version = "1.14.4"
  end

  def launch(install_path)
    "cd #{install_path} && java -Xms1G -Xmx2G -jar spigot.jar --noconsole"
  end

  def install_server(install_path, version = @version)
    FileUtils.mkdir_p(install_path)
    File.open("#{install_path}/BuildTools.jar", "wb") do |file|
      file.write(open("https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar").read())
    end
    system("cd #{install_path} && java -jar #{install_path}/BuildTools.jar --rev #{version}")
  end

  def post_install(install_path, version = @version)
    system("rm -f #{install_path}/eula.txt")
    system("touch #{install_path}/eula.txt")
    system("echo 'eula=true' >> #{install_path}/eula.txt")

    system("mv #{install_path}/spigot-#{version}.jar #{install_path}/spigot.jar")
  end
end
