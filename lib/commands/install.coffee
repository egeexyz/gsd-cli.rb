{ Command, flags } = require('@oclif/command')

class InstallCommand extends Command
  run: ->
    { flags } = this.parse(InstallCommand)
    name = flags.name || 'world'
    this.log("hello #{name} from ./dist/index.js")


InstallCommand.description = "Basically just chillin"

InstallCommand.flags = {
  name: flags.string({char: 'n', description: 'name to print'}),
}

module.exports = InstallCommand
