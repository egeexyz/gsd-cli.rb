fs                 = require("fs").promises
Chalk              = require("chalk")
GameServer         = require("../server_builder")
{ Command, flags } = require('@oclif/command')
{ execSync, exec }       = require 'child_process'

class BootstrapCommand extends Command
  run: ->
    srcPath = "/home/#{process.env.USER}/.local/gsd-cli"
    execSync("rm -rf #{srcPath}")
    execSync("git clone https://github.com/Egeeio/gsd-cli.git #{srcPath}")

    configFiles = await fs.readdir("#{srcPath}/configs")

    replaceName = (file) -> exec("sed -i \"s/travis/#{process.env.USER}/\" #{srcPath}/configs/#{file}")
    configFiles.forEach(file) -> replaceName(file)

BootstrapCommand.description = "Bootstrap some game config files"

module.exports = BootstrapCommand
