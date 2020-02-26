fs                 = require("fs")
Chalk              = require("chalk")
GameServer         = require("../server_builder")
{ Command, flags } = require('@oclif/command')
{ execSync }       = require 'child_process'

class InstallCommand extends Command
  configParser: (flags) ->
    jsonConfig = JSON.parse(fs.readFileSync(flags.file))
    flags.config = jsonConfig
    flags.path = "/home/#{flags.config.meta.user}/#{flags.config.meta.game}-server"
    this.log "server will be installed to #{flags.path}"
    execSync("mkdir -p /home/#{flags.config.meta.user}/.config/systemd/user")
  flagParser: (flags) ->
    if flags.file && flags.name
      this.log(Chalk.red.bold("Using -f and -n flags together is not supported. Use one or the other."))
      process.exit()
    else if flags.name
      execSync("gsd-cli bootstrap -n #{flags.name}")
      flags.file = "#{process.env.PWD}/#{flags.name}.json"
      this.log(Chalk.blue("Created '#{flags.name}' config file at: #{process.env.PWD}/#{flags.file}"))
    try
      jsonConfig = this.configParser(flags)
    catch e
      this.log(Chalk.red.bold("Error parsing config file: #{e}"))
      process.exit()
    return jsonConfig
  run: ->
    { flags } = this.parse(InstallCommand)
    this.flagParser(flags)
    GameServer.install(flags)

InstallCommand.description = "Installs a dedicated game server using a config file or a name with default settings."

InstallCommand.flags = {
  name:   flags.string( {char: 'n', description: 'name of the server to install'}),
  file:   flags.string( {char: 'f', description: 'path to the config file'}),
  dryrun: flags.boolean({char: 'd', description: 'test installing a server without actually installing it'}),
}

module.exports = InstallCommand