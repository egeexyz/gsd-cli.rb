fs                 = require("fs")
Chalk              = require("chalk")
GameServer         = require("../server_builder")
{ Command, flags } = require('@oclif/command')
{ execSync }       = require 'child_process'

class BootstrapCommand extends Command
  run: ->
    srcPath = "/home/#{process.env.USER}/.local/gsd-cli"
    execSync("rm -rf #{srcPath}")
    execSync("git clone https://github.com/Egeeio/gsd-cli.git #{srcPath}")
    console.log fs.dir.readSync("#{srcPath}/configs") # https://nodejs.org/api/fs.html#fs_fs_opendir_path_options_callback
    
    # { flags } = this.parse(BootstrapCommand)
    # try
    #   jsonConfig = JSON.parse(fs.readFileSync(flags.file))
    #   flags.config = jsonConfig
    # catch e
    #   this.error(Chalk.red.bold("Error parsing config file: #{e}"))
    #   process.exit
    
    # flags.path = "/home/#{flags.config.meta.user}/#{flags.config.meta.game}-server"
    # this.log "server will be Bootstraped to #{flags.path}"
    # execSync("mkdir -p /home/#{flags.config.meta.user}/.config/systemd/user")
    # GameServer.Bootstrap(flags)

BootstrapCommand.description = "Bootstrap some game config files"

module.exports = BootstrapCommand
