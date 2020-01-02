fs                 = require("fs")
Chalk              = require("chalk")
GameServer         = require("../server_builder")
{ Command, flags } = require('@oclif/command')
{ execSync }       = require 'child_process'

class InstallCommand extends Command
  run: ->
    { flags } = this.parse(InstallCommand)
    try
      content = JSON.parse(fs.readFileSync(flags.file))
      flags.config = content
    catch e
      this.error(Chalk.red.bold("Error parsing config file: #{e}"))
      process.exit
    
    flags.path = "/home/#{flags.config.meta.user}/#{flags.config.meta.game}-server"
    fs.writeFile "#{flags.path}/cache.json", JSON.stringify(content), (err) =>
      throw err if err
    this.log "server will be installed to #{flags.path}"
    GameServer.install(flags)

InstallCommand.description = "install a dedicated game server as a daemon"

InstallCommand.flags = {
  name:   flags.string( {char: 'n', description: 'game server to install'}),
  file:   flags.string( {char: 'f', description: 'path to the config file'}),
  dryrun: flags.boolean({char: 'd', description: 'test installing a server without actually installing it'}),
}

module.exports = InstallCommand
