# Create a Rust server
class Rust
  attr_reader :name, :install_path
  def initialize(install_path = "")
    @name = "rust"
    @app_id = "258550"
    @install_path = "/tmp/#{@name}" if install_path.empty?
    @log_path = "#{@install_path}/server.log"
  end

  def run
    pid = spawn("export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:#{@install_path}/RustDedicated_Data/Plugins/x86_64 &&
      cd #{@install_path} &&
      ./RustDedicated \
      +server.ip 0.0.0.0 \
      +server.port 28015 \
      +server.identity rust \
      +rcon.web 1 \
      +rcon.ip 0.0.0.0 \
      +rcon.port 28016 \
      +rcon.password 101")
      Process.detach(pid)
  end

  def start
    # TODO: This solution "works" in that it forks a new sub process but...
    # It leaves a dangling Ruby process running
    # When the terminal is closed, it deletes stdout (1) from /proc/
    p1 = fork do
      %x"export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:#{@install_path}/RustDedicated_Data/Plugins/x86_64 &&
      cd #{@install_path} &&
      ./RustDedicated \
      +server.ip 0.0.0.0 \
      +server.port 28015 \
      +server.identity rust \
      +rcon.web 1 \
      +rcon.ip 0.0.0.0 \
      +rcon.port 28016 \
      +rcon.password 101"
    end
    Process.detach(p1)
  end

  def install
    puts "Beginning installation process. This may take a while..."
    system("/usr/games/steamcmd +login anonymous +quit")
    `/usr/games/steamcmd +login anonymous +force_install_dir #{@install_path} +app_update #{@app_id} validate +quit`
    system("touch #{@log_path}")
    puts "Install complete."
  end

  def env_vars
    "LD_LIBRARY_PATH=$LD_LIBRARY_PATH:#{@install_path}/RustDedicated_Data/Plugins/x86_64"
  end

  def exec_start
    "#{Dir.pwd}/bin/gsd run rust"
  end
end
