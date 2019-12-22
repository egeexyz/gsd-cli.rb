GenericServer   = require("./generic")
{ execSync }    = require("child_process")

class SrcdsServer extends GenericServer
  @install: (flags) ->
    super(flags)
    steamLogin = "+login #{flags.config.steamUserName} #{flags.config.steamPassword}"
    install_cmd = "steamcmd #{steamLogin} +force_install_dir #{flags.path} +app_update #{flags.config.appId} validate +quit"
    execSync(install_cmd) unless flags.dryrun == true

    this.createUnitFile(flags)
    this.createLaunchScript(flags)
    this.createLogFile(flags)
  @createUnitFile: (flags) ->
    super(flags)
  @createLaunchScript: (flags) ->
    launchFileContents = """
                      ./srcds_run \
                      -console \
                      -game #{flags.config.meta.game} \
                      +map #{flags.config.defaultMap} \
                      +maxplayers #{flags.config.players} \
                      #{flags.config.srcdsParams} \
                      -condebug & \
                      /usr/bin/tail -f #{flags.path}/#{flags.config.meta.game}/console.log
                        """
    super(flags, launchFileContents)
  @createLogFile: (flags) ->
    execSync("touch #{flags.path}/#{flags.config.meta.game}/console.log")
  @backupFile: (file) ->
    execSync("touch #{file}")
    execSync("rm -f #{file}.backup")
    execSync("mv #{file} #{file}.backup")
module.exports = SrcdsServer
