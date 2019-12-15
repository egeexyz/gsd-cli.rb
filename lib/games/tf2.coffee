GameServer   = require("./game_server")
{ execSync } = require("child_process")

class Tf2
  @install: (flags) ->
    execSync("mkdir -p /home/#{process.env.USER}/#{flags.name}-server")
    install_cmd = "steamcmd +login #{flags.steam_login} +force_install_dir #{flags.path} +app_update #{flags.app_id} validate +quit"
    execSync(install_cmd) unless flags.dryrun == true
    this.createUnitFile(flags)
    this.createLaunchScript(flags)
    this.createLogFile(flags)
    return "Installing, please wait"
  @createUnitFile: (flags) ->
    unit_path = "/home/#{process.env.USER}/.config/systemd/user/#{flags.name}.service"
    unitFileContents = """
                       [Unit]
                       After=network.target
                       Description=Daemon for #{flags.name} dedicated server
                       [Install]
                       WantedBy=default.target
                       [Service]
                       Type=simple
                       WorkingDirectory=#{flags.path}
                       ExecStart=/bin/bash #{flags.path}/launch.sh
                       """
    execSync("echo '#{unitFileContents}' >> #{unit_path}")
  @createLaunchScript: (flags) ->
    logFilePath = "#{flags.path}/console.log"
    launchFilePath = "#{flags.path}/launch.sh"
    launchFileContents = """
                        ./srcds_run \
                        -console \
                        -game #{flags.internal_name} \
                        +map #{flags.map} \
                        +maxplayers #{flags.players} \
                        +sv_pure 1 \
                        -condebug & \
                        /usr/bin/tail -f ./console.log
                         """
    this.backupFile(launchFilePath)
    execSync("rm -f #{launchFilePath}")
    execSync("touch #{launchFilePath}")
    execSync("echo '#{launchFileContents}' >> #{launchFilePath}")
    execSync("chmod +x #{launchFilePath}")
  @createLogFile: (flags) ->
    execSync("touch #{flags.path}/console.log")
  @backupFile: (file) ->
    execSync("touch #{file}")
    execSync("rm -f #{file}.backup")
    execSync("mv #{file} #{file}.backup")
module.exports = Tf2
