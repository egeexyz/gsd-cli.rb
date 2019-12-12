{ Command, flags } = require('@oclif/command')

class InstallCommand extends Command
  run: ->
    { flags } = this.parse(InstallCommand)
    flags.path = "/home/#{flags.name}/#{flags.name}-server" if !flags.path
    this.log("You want to install #{flags.name} at path: #{flags.path}")

InstallCommand.description = "install a dedicated game server as a daemon"

InstallCommand.flags = {
  name: flags.string({char: 'n', description: 'game server to install'}),
  path: flags.string({char: 'p', description: 'path the game server will be installed to'}),
}

module.exports = InstallCommand
