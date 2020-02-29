fs                 = require("fs").promises
Chalk              = require("chalk")
GameServer         = require("../server_builder")
{ Command, flags } = require('@oclif/command')
{ execSync, exec, spawn }       = require 'child_process'

class BootstrapCommand extends Command
  tmpPath = "/tmp/gsd-config"
  gameLookup = {
    gmod: 'gmod.json',
    minecraft: 'minecraft.json',
    rust: 'rust.json',
    sdtd: 'sdtd.json',
    tf2: 'tf2.json',
    scp: 'scp.json'
  }
  downloadFile: () ->
    execSync("rm -rf #{tmpPath}")
    execSync("git clone https://github.com/Egeeio/gsd-config.git #{tmpPath} --quiet")
  transformConfig: (name) ->
    filePath = "#{tmpPath}/#{gameLookup[name]}"

    execSync("sed -i \"s/USER_NAME/#{process.env.USER}/\" #{filePath}")
    execSync("cp -f #{filePath} #{process.env.PWD}")
    this.log(Chalk.blue("Created '#{flags.name}' config file at: #{process.env.PWD}/#{filePath}"))
  run: ->
    { flags } = this.parse(BootstrapCommand)

    if gameLookup[flags.name]
      this.downloadFile()
      this.transformConfig(flags.name)
    else
      this.log(Chalk.red.bold("Unable to find '#{flags.name}' in supported games list."))
      process.exit()

BootstrapCommand.description = "Creates a default gsd game configuration file and places it in the current directory."

BootstrapCommand.flags = {
  name:   flags.string( {char: 'n', description: 'name of the server to to pull configs for'})
}

module.exports = BootstrapCommand
