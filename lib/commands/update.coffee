{ Command, flags } = require('@oclif/command')

class UpdateCommand extends Command
  run: ->
    { flags } = this.parse(UpdateCommand)
    name = flags.name || 'world'
    this.log("hello #{name} from ./dist/index.js")


UpdateCommand.description = "Basically just chillin"

UpdateCommand.flags = {
  name: flags.string({char: 'n', description: 'name to print'}),
}

module.exports = UpdateCommand
