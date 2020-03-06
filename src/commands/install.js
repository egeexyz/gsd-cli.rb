const fs = require('fs')
const Chalk = require('chalk')
const GameList = require('../supported-games')
const SteamCmd = require('../installers/steamcmd')
const { Command, flags } = require('@oclif/command')

class InstallCommand extends Command {
  nameChanger (game) {
    switch (game.name) {
      case 'tf2':
        this.log('internal name changed to tf')
        game.name = 'tf'
        break
      case 'gmod':
        this.log('internal name changed to garrysmod')
        game.name = 'garrysmod'
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
    const steamCmd = new SteamCmd(this.gameBuilder(flags))
    steamCmd.install()
  }
}

InstallCommand.description = 'Installs a dedicated game server using a config file or a name with default settings.'

InstallCommand.flags = {
  name: flags.string({ char: 'n', description: 'name of the server to install' }),
  dryrun: flags.boolean({ char: 'd', description: 'test installing a server without actually installing it' })
}

module.exports = InstallCommand
