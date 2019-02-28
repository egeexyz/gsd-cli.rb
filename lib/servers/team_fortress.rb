# A module to produce resources for a Team Fortress 2 server
module TeamFortress
  def self.exec_start(file_path = "/tmp/gsd/tf2/server_files",
                 log_path = "/tmp/gsd/tf2/server_files/tf/console.log",
                 map = "ctf_2fort",
                 players = 24)
    "#{file_path}/srcds_run \
    -console \
    -game tf \
    +sv_pure 1 \
    +map #{map} \
    +maxplayers #{players} \
    -condebug & \
    /usr/bin/tail -f #{log_path}"
  end
end
