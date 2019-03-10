# Create a Rust server
class Rust
  attr_reader :name, :app_id
  def initialize
    @name = "rust"
    @app_id = "258550"
  end

  def launch(install_path, password = "_", ip = "0.0.0.0", port = "28016")
    "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:#{install_path}/RustDedicated_Data/Plugins/x86_64 &&
     cd #{install_path} &&
     ./RustDedicated +server.ip #{ip} +server.port #{port} +server.identity rust +rcon.web 1 \
     +rcon.ip #{ip} \
     +rcon.port 28016 \
     +rcon.password #{password}"
  end

  def unit_file_contents
    "[Unit]
    After=network.target
    Description=#{@desc}
    [Install]
    WantedBy=default.target
    [Service]
    WorkingDirectory=#{Dir.pwd}
    Type=forking
    User=#{@user}
    ExecStart=#{Dir.pwd}/bin/gsd run #{@name}"
  end
end
