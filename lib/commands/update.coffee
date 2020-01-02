fs                 = require("fs")
Chalk              = require("chalk")
GameServer         = require("../server_builder")
{ Command, flags } = require('@oclif/command')
{ execSync }       = require 'child_process'

class UpdateCommand extends Command
  run: ->
    { flags } = this.parse(UpdateCommand)
    if !flags.path
      flags.path = "/home/#{process.env.USER}/#{flags.name}-server"
      this.log("Path was not provided; defaulting to #{flags.path}")
      try
        execSync("stat #{flags.path}")
      catch e
        this.error(Chalk.red.bold("Error parsing install path: #{e}"))
        process.exit
    jsonConfig = JSON.parse(fs.readFileSync("#{flags.path}/cache.json"))
    flags = jsonConfig
    GameServer.install(flags)


UpdateCommand.description = "Updates an installed dedicated game server"

UpdateCommand.flags = {
  name: flags.string({char: 'n', description: 'game server to update'}),
  path: flags.string({char: 'p', description: 'path the game server is installed at'}),
}

module.exports = UpdateCommand
