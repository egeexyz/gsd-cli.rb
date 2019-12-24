Chalk           = require("chalk")
GenericServer   = require("./generic")
{ execSync }    = require("child_process")

class Minecraft extends GenericServer
  @install: (flags) ->
    super(flags)
    this.downloadBuildTools(flags)
    console.log(Chalk.blue.bold("Running Spigot BuildTools.jar. This will take a while... ⏳"))
    console.log(execSync("java -Xmx1024M -jar BuildTools.jar", {"cwd": "#{flags.path}"}).toString()) unless flags.dryrun == true
    this.createUnitFile(flags)
    this.createLaunchScript(flags)
    this.postInstall(flags)
  @createUnitFile: (flags) ->
    super(flags)
  @createLaunchScript: (flags) ->
    launchFileContents = """java -Xms1G -Xmx2G -server -jar #{flags.path}/spigot-#{flags.version}.jar --noconsole"""
    super(flags, launchFileContents)
  @createLogFile: (flags) ->
    super(flags)
  @backupFile: (file) ->
    super(file)
  @downloadBuildTools: (flags) ->
    buildToolsUrl = "https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar"
    execSync("rm -f BuildTools.jar", {"cwd": "#{flags.path}"})
    execSync("wget #{buildToolsUrl}", {"cwd": "#{flags.path}"})
  @postInstall: (flags) ->
    execSync("rm -f #{flags.path}/eula.txt")
    execSync("touch #{flags.path}/eula.txt")
    execSync("echo 'eula=true' >> #{flags.path}/eula.txt")
module.exports = Minecraft
