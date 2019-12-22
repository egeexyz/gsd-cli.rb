Chalk           = require("chalk")
GenericServer   = require("./generic")
{ execSync }    = require("child_process")

class Minecraft extends GenericServer
  @install: (flags) ->
    super(flags)
    this.downloadBuildTools(flags)
    console.log(Chalk.blue.bold("Running Spigot BuildTools.jar. This will take a while... ⏳"))
    console.log(execSync("java -Xmx1024M -jar BuildTools.jar", {"cwd": "#{flags.installPath}"}).toString()) unless flags.dryrun == true
    this.createUnitFile(flags)
    this.createLaunchScript(flags)
    this.postInstall(flags)
  @createUnitFile: (flags) ->
    super(flags)
  @createLaunchScript: (flags) ->
    launchFileContents = """java -Xms1G -Xmx2G -server -jar #{flags.installPath}/spigot-#{flags.version}.jar --noconsole"""
    super(flags, launchFileContents)
  @createLogFile: (flags) ->
    super(flags)
  @backupFile: (file) ->
    super(file)
  @downloadBuildTools: (flags) ->
    buildToolsUrl = "https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar"
    execSync("rm -f BuildTools.jar", {"cwd": "#{flags.installPath}"})
    execSync("wget #{buildToolsUrl}", {"cwd": "#{flags.installPath}"})
  @postInstall: (flags) ->
    execSync("rm -f #{flags.installPath}/eula.txt")
    execSync("touch #{flags.installPath}/eula.txt")
    execSync("echo 'eula=true' >> #{flags.installPath}/eula.txt")
module.exports = Minecraft
