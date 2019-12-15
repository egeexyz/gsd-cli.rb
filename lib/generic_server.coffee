{ execSync } = require("child_process")

class GenericServer
  @install: (flags) ->
    execSync("mkdir -p /home/#{process.env.USER}/#{flags.name}-server")
  @createUnitFile: (flags) ->
  @createLaunchScript: (flags) ->
  @createLogFile: (flags) ->
    execSync("touch #{flags.path}/console.log")
  @backupFile: (file) ->
    execSync("touch #{file}")
    execSync("rm -f #{file}.backup")
    execSync("mv #{file} #{file}.backup")
module.exports = GenericServer
