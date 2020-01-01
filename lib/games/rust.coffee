GenericServer   = require("./generic")
{ execSync }    = require("child_process")

class RustServer extends GenericServer
  @install: (flags) ->
    super(flags)
    steamLogin = "+login #{flags.config.steamUserName} #{flags.config.steamPassword}"
    install_cmd = "steamcmd #{steamLogin} +force_install_dir #{flags.path} +app_update #{flags.config.appId} validate +quit"
    execSync(install_cmd) unless flags.dryrun == true

    this.createUnitFile(flags)
    this.createLaunchScript(flags)
  @createUnitFile: (flags) ->
    super(flags)
  @createLaunchScript: (flags) ->
    ## Because of the export LD_LIBRARY_PATH bullshit, this is way more work than it looks
    launchFileContents = """
                        export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:#{flags.path}/RustDedicated_Data/Plugins/x86_64
                        ./RustDedicated \
                        +server.ip #{flags.config.ip} \
                        +server.port #{flags.config.gamePort} \
                        +server.identity rust \
                        +rcon.web 1 \
                        +rcon.ip #{flags.config.ip} \
                        +rcon.port #{flags.config.rconPort} \
                        +rcon.password #{flags.config.rconPassword}
                        """
    super(flags, launchFileContents)
  @createLogFile: (flags) ->
    execSync("touch #{flags.path}/#{flags.config.meta.game}/console.log")
  @backupFile: (file) ->
    execSync("touch #{file}")
    execSync("rm -f #{file}.backup")
    execSync("mv #{file} #{file}.backup")

module.exports = RustServer
