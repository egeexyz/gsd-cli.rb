Chalk        = require("chalk")
{ execSync } = require("child_process")

class GenericServer
  @install: (flags) ->
    console.info(Chalk.blue.bold("Installing, please wait... ⏳"))
    execSync("mkdir -p /home/#{process.env.USER}/#{flags.name}-server")
  @createUnitFile: (flags) ->
    unit_path = "/home/#{process.env.USER}/.config/systemd/user/#{flags.name}.service"
    unitFileContents = """
                       [Unit]
                       After=network.target
                       Description=Daemon for #{flags.name} dedicated server
                       [Install]
                       WantedBy=default.target
                       [Service]
                       Type=simple
                       WorkingDirectory=#{flags.path}
                       ExecStart=/bin/bash #{flags.path}/launch.sh
                       """
    execSync("rm -f #{unit_path}")
    execSync("touch #{unit_path}")
    execSync("echo '#{unitFileContents}' >> #{unit_path}")
  @createLaunchScript: (flags, launchFileContents) ->
    logFilePath = "#{flags.path}/console.log"
    launchFilePath = "#{flags.path}/launch.sh"
    this.backupFile(launchFilePath)
    execSync("rm -f #{launchFilePath}")
    execSync("touch #{launchFilePath}")
    execSync("echo '#{launchFileContents}' >> #{launchFilePath}")
    execSync("chmod +x #{launchFilePath}")
  @createLogFile: (flags) ->
    execSync("touch #{flags.path}/console.log")
  @backupFile: (file) ->
    execSync("touch #{file}")
    execSync("rm -f #{file}.backup")
    execSync("mv #{file} #{file}.backup")
module.exports = GenericServer
