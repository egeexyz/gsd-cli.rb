GenericServer   = require("./generic")
{ execSync }    = require("child_process")

class SrcdsServer extends GenericServer
  @install: (flags) ->
    super(flags)

    install_cmd = "steamcmd +login #{flags.steam_login} +force_install_dir #{flags.path} +app_update #{flags.app_id} validate +quit"

    execSync("mkdir -p /home/#{process.env.USER}/#{flags.name}-server/#{flags.internal_name}")
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
                      -game #{flags.internal_name} \
                      +map #{flags.map} \
                      +maxplayers #{flags.players} \
                      #{flags.custom_params} \
                      -condebug & \
                      /usr/bin/tail -f #{flags.path}/#{flags.internal_name}/console.log
                        """
    super(flags, launchFileContents)
  @createLogFile: (flags) ->
    execSync("touch #{flags.path}/#{flags.internal_name}/console.log")
  @backupFile: (file) ->
    execSync("touch #{file}")
    execSync("rm -f #{file}.backup")
    execSync("mv #{file} #{file}.backup")
module.exports = SrcdsServer
