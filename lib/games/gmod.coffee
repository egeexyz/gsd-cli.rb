GameServer   = require("./game_server")
{ execSync } = require("child_process")

class Gmod
  @install: (flags) ->
    install_cmd = "steamcmd +login #{flags.steam_login} +force_install_dir #{flags.path} +app_update #{flags.app_id} validate +quit"
    unit_path = "/home/#{process.env.USER}/.config/systemd/user/#{flags.name}.service"
    execSync(install_cmd) unless flags.dryrun == true
    execSync("echo '#{this.unitFile(flags)}' >> #{unit_path}")
    return "Installing, please wait"
  @unitFile: (flags) ->
    """
    [Unit]
    After=network.target
    Description=Daemon for #{flags.name} dedicated server
    [Install]
    WantedBy=default.target
    [Service]
    Type=simple
    ExecStart=#{flags.path}
    """

module.exports = Gmod
