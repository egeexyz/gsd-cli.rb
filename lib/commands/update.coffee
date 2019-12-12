{ Command, flags } = require('@oclif/command')

class UpdateCommand extends Command
  run: ->
    { flags } = this.parse(UpdateCommand)
    flags.path = "/opt/#{flags.name}" if !flags.path
    this.log("You want to launch #{flags.name} installed at: #{flags.path}")


UpdateCommand.description = "Updates an installed dedicated game server"

UpdateCommand.flags = {
  name: flags.string({char: 'n', description: 'game server to launch'}),
  path: flags.string({char: 'p', description: 'path the game server is installed at'}),
}

module.exports = UpdateCommand
