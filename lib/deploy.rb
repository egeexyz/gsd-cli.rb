require "./lib/daemonize"

# The class that deploys the game servers as daemons
module Deploy
  def self.it(daemon)
    system("sudo -p 'sudo password: ' cp -f #{daemon.file_path} /etc/systemd/system/#{daemon.game}.service")
  end
end
