{Command, flags} = require('@oclif/command')

class GsdCliCommand extends Command
  run: ->
    {flags} = this.parse(GsdCliCommand)
    name = flags.name || 'world'
    this.log("hello #{name} from ./dist/index.js")


GsdCliCommand.description = "Describe the command here"

GsdCliCommand.flags = {
  # add --version flag to show CLI version
  version: flags.version({char: 'v'}),
  # add --help flag to show CLI version
  help: flags.help({char: 'h'}),
  name: flags.string({char: 'n', description: 'name to print'}),
}

module.exports = GsdCliCommand

