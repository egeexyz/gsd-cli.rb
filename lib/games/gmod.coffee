GameServer   = require("./game_server")
{ execSync } = require("child_process")

class Gmod
  @install: (flags) ->
    install_cmd = "steamcmd +login #{flags.steam_login} +force_install_dir #{flags.path} +app_update #{flags.app_id} validate +quit"
    execSync(install_cmd) unless flags.dryrun == true
    this.createUnitFile(flags)
    this.createLaunchScript(flags)
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
                       ExecStart=#{flags.path}/launch.sh
                       """
    execSync("echo '#{unitFileContents}' >> #{unit_path}")
  @createLaunchScript: (flags) ->
    logFilePath = "#{flags.path}/console.log"
    launchFilePath = "#{flags.path}/launch.sh"
    launchFileContents = """
                        ./srcds_run \
                        -console \
                        -game garrysmod \
                        +map #{flags.map} \
                        +maxplayers #{flags.players} \
                        +host_workshop_collection #{flags.collection_id} \
                        -condebug & \
                        /usr/bin/tail -f ./console.log
                         """
    this.backupFile(launchFilePath)
    execSync("rm -f #{launchFilePath}")
    execSync("touch #{launchFilePath}")
    execSync("echo '#{launchFileContents}' >> #{launchFilePath}")
  @backupFile: (file) ->
    execSync("touch #{file}")
    execSync("rm -f #{file}.backup")
    execSync("mv #{file} #{file}.backup")
module.exports = Gmod
