const fs = require('fs')
const Chalk = require('chalk')
const GameList = require('./../games')
const SteamCmdServer = require('./../builders/steamcmd')
const { Command, flags } = require('@oclif/command')
const { execSync } = require('child_process')

class InstallCommand extends Command {
  configParser (flags) {
    const jsonConfig = JSON.parse(fs.readFileSync(flags.file))
    flags.config = jsonConfig
    flags.path = '/home/#{flags.config.meta.user}/#{flags.config.meta.game}-server'
    this.log('server will be installed to #{flags.path}')
    execSync('mkdir -p /home/#{flags.config.meta.user}/.config/systemd/user')
  }

  nameChanger (game) {
    switch (game.name) {
      case 'tf2':
        game.name = 'tf'
        break
    }
  }

  gameBuilder (flags) {
    const game = GameList.filter((item) => { return flags.name === item.name }).pop()
    if (game) {
      this.nameChanger(game)
      game.user = process.env.USER
      game.path = `/home/${game.user}/${game.name}-server`
      game.dryrun = flags.dryrun
      return game
    } else {
      this.log(`${flags.name} not supported`)
      process.exit()
    }
  }

  run () {
    const { flags } = this.parse(InstallCommand)
    SteamCmdServer.install(this.gameBuilder(flags))
  }
}

InstallCommand.description = 'Installs a dedicated game server using a config file or a name with default settings.'

InstallCommand.flags = {
  name: flags.string({ char: 'n', description: 'name of the server to install' }),
  dryrun: flags.boolean({ char: 'd', description: 'test installing a server without actually installing it' })
}

module.exports = InstallCommand
