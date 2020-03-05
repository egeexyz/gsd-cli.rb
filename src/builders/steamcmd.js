const BaseServer = require('./base')
const { exec } = require('child_process')

class SteamCmdServer extends BaseServer {
  static install (game) {
    const steamLogin = `+login ${game.steamUserName} ${game.steamPassword}`
    const installCmd = `steamcmd ${steamLogin} +force_install_dir ${game.path} +app_update ${game.appId} validate +quit`
    game.steamUserName = 'anonymous'
    game.steamPassword = ''

    super.install(game)
    super.createUnitFile(game)
    super.createLaunchScript(game, `${game.launchParams} & /usr/bin/tail -f ${game.path}/console.log`)
    exec(`mkdir -p ${game.path}/${game.name}`)
    exec(`touch ${game.path}/${game.name}/console.log`)
    if (game.dryrun) {
      return
    }
    exec(installCmd)
  }
}

module.exports = SteamCmdServer
