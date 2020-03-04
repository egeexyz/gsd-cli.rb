GenericServer   = require("./generic")
{ execSync }    = require("child_process")

class SdtdServer extends GenericServer
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
    ## Because of the export LD_LIBRARY_PATH bullshit, this is way more work than it looks
    launchFileContents = """
                        export LD_LIBRARY_PATH=.
                        #{flags.path}/7DaysToDieServer.x86_64 \
                        -logfile #{flags.path}/console.log \
                        -quit \
                        -batchmode \
                        -nographics \
                        -dedicated \
                        -configfile=#{flags.path}/serverconfig.xml & \
                        /usr/bin/tail -f #{flags.path}/console.log
                        """
    super(flags, launchFileContents)
  @createLogFile: (flags) ->
    execSync("touch #{flags.path}/console.log")
  @backupFile: (file) ->
    execSync("touch #{file}")
    execSync("rm -f #{file}.backup")
    execSync("mv #{file} #{file}.backup")

module.exports = SdtdServer
