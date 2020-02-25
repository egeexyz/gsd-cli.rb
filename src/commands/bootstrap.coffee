fs                 = require("fs").promises
Chalk              = require("chalk")
GameServer         = require("../server_builder")
{ Command, flags } = require('@oclif/command')
{ execSync, exec, spawn }       = require 'child_process'

class BootstrapCommand extends Command
  gameLookup = {
    gmod: 'gmod.json',
    minecraft: 'minecraft.json',
    rust: 'rust.json',
    sdtd: 'sdtd.json',
    tf2: 'tf2'
  }
  run: ->
    { flags } = this.parse(BootstrapCommand)
    homePath = "/home/#{process.env.USER}/gsd-config"
    tmpPath = "/tmp/gsd-config"
    execSync("rm -rf #{tmpPath}")
    execSync("git clone https://github.com/Egeeio/gsd-config.git #{tmpPath}")
    filePath = "#{tmpPath}/#{gameLookup[flags.name]}"


    execSync("sed -i \"s/USER_NAME/#{process.env.USER}/\" #{filePath}")
    execSync("cp #{filePath} #{process.env.PWD}")
    console.log (execSync("cat #{process.env.PWD}/#{gameLookup[flags.name]}").toString())

BootstrapCommand.description = "Bootstrap some game config files"

BootstrapCommand.flags = {
  name:   flags.string( {char: 'n', description: 'name of the server to to pull configs for'})
}

module.exports = BootstrapCommand
