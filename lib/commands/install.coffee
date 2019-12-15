{ Command, flags } = require('@oclif/command')
GameServer = require("../server_builder")
{ execSync } = require 'child_process'

class InstallCommand extends Command
  run: ->
    { flags } = this.parse(InstallCommand)
    flags.path = "/home/#{process.env.USER}/#{flags.name}-server" if !flags.path
    GameServer.install(flags)

InstallCommand.description = "install a dedicated game server as a daemon"

InstallCommand.flags = {
  name:   flags.string( {char: 'n', description: 'game server to install', required: true}),
  path:   flags.string( {char: 'p', description: 'path the game server will be installed to'}),
  dryrun: flags.boolean({char: 'd', description: 'test installing a server without actually installing it'}),
}

module.exports = InstallCommand
