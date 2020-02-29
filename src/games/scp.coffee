GenericServer   = require("./generic")
{ execSync }    = require("child_process")

class ScpServer extends GenericServer
  @install: (flags) ->
    super(flags)
    steamLogin = "+login #{flags.config.steamUserName} #{flags.config.steamPassword}"
    install_cmd = "steamcmd #{steamLogin} +force_install_dir #{flags.path} +app_update #{flags.config.appId} validate +quit"
    execSync(install_cmd) unless flags.dryrun == true

module.exports = ScpServer
