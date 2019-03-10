# Create a 7 Days to Die server
class SevenDays
  attr_reader :name, :app_id
  def initialize
    @name = "sdtd"
    @app_id = "294420"
  end

  def launch(install_path)
    "cd #{install_path} &&
     export LD_LIBRARY_PATH=. &&
     #{install_path}/7DaysToDieServer.x86_64 -logfile #{install_path}/console.log \
     -quit -batchmode -nographics -dedicated & /usr/bin/tail -f #{install_path}/server.log"
  end

  def post_install(install_path)
    system("rm #{install_path}/serverconfig.xml")
    system("cp #{Dir.pwd}/conf/sdtd.xml #{install_path}/serverconfig.xml")
  end
end
