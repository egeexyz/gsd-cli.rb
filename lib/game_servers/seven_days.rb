# Create a 7 Days to Die server
class SevenDays
  attr_reader :name, :app_id
  def initialize
    @name = "sdtd"
    @app_id = "294420"
  end

  def launch(install_path, log_path)
    "#{install_path}/startserver.sh -configfile=serverconfig.xml & /usr/bin/tail -f #{install_path}/server.log"
  end

  def post_install(install_path)
    system("rm #{install_path}/serverconfig.xml")
    system("rm #{install_path}/startserver.sh")
    system("curl https://s3-us-west-2.amazonaws.com/gsd-sdtd/serverconfig.xml > #{install_path}/serverconfig.xml")
    system("curl https://s3-us-west-2.amazonaws.com/gsd-sdtd/startserver.sh > #{install_path}/startserver.sh")
  end
end
