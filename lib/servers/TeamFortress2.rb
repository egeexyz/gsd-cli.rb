# Comment
class TeamFortress2
  def initialize(file_path = '/tmp/gsd/tf2/server_files',
                 log_path = '/tmp/gsd/tf2/server_files/tf/console.log',
                 map = 'ctf_2fort',
                 players = 24)
    @map = map
    @players = players
    @log_path = log_path
    @file_path = file_path
  end

  def exec_start
    "#{file_path}/srcds_run \
    -console \
    -game tf \
    +sv_pure 1 \
    +map #{@map} \
    +maxplayers #{@players} \
    -condebug & \
    /usr/bin/tail -f #{@log_path}"
  end
end
