{ Command, flags } = require('@oclif/command')

class LaunchCommand extends Command
  run: ->
    { flags } = this.parse(LaunchCommand)
    flags.path = "/opt/#{flags.name}" if !flags.path
    this.log("You want to launch #{flags.name} installed at: #{flags.path}")


LaunchCommand.description = "Launch a dedicated game server as a new process."

LaunchCommand.flags = {
  name: flags.string({char: 'n', description: 'game server to launch'}),
  path: flags.string({char: 'p', description: 'path the game server will be installed to'}),
}

module.exports = LaunchCommand
