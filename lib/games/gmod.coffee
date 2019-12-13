GameServer   = require("./game_server")
{ execSync } = require("child_process")

class Gmod
  @install: (flags) ->
    install_cmd = "/usr/games/steamcmd +login #{flags.steam_login} +force_install_dir #{flags.path} +app_update #{flags.app_id} validate +quit"
    execSync(install_cmd) unless flags.dryrun == true
    return "Installing, please wait"

module.exports = Gmod
