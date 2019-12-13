{ Command, flags } = require('@oclif/command')
GameServer = require("../games/game_server")
{ execSync } = require 'child_process'

class InstallCommand extends Command
  run: ->
    { flags } = this.parse(InstallCommand)
    flags.path = "/home/#{process.env.USER}/#{flags.name}-server" if !flags.path
    this.install()
  install: ->
    this.log("You appear to want to install #{flags.name} at path: #{flags.path}")
    execSync("rm -f /home/#{process.env.USER}/.config/systemd/user/#{flags.name}.service")
    execSync("touch /home/#{process.env.USER}/.config/systemd/user/#{flags.name}.service")
    gameServer = GameServer.install flags
    console.log gameServer

InstallCommand.description = "install a dedicated game server as a daemon"

InstallCommand.flags = {
  name:   flags.string({char: 'n', description: 'game server to install'}),
  path:   flags.string({char: 'p', description: 'path the game server will be installed to'}),
  dryrun: flags.string({char: 'd', description: 'test installing a server without actually installing it'}),
}

module.exports = InstallCommand
