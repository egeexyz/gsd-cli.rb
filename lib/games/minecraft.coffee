GenericServer   = require("../generic_server")
{ execSync }    = require("child_process")

class Minecraft extends GenericServer
  
  @install: (flags) ->
    super(flags)
    buildToolsUrl = "https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar"
    installPath = "/home/#{process.env.USER}/#{flags.name}-server"
    execSync("wget #{buildToolsUrl} -o #{installPath}")
  @createUnitFile: (flags) ->
    super(flags)
  @createLaunchScript: (flags) ->
    super(flags)
  @createLogFile: (flags) ->
    super(flags)
  @backupFile: (file) ->
    super(file)
module.exports = Minecraft
