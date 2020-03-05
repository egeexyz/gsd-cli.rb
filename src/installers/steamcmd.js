const Chalk = require('chalk')
const BaseInstaller = require('./base')
const { execSync, exec } = require('child_process')
const { enableLogging } = require('./backends/srcds')

class SteamCmd extends BaseInstaller {
  constructor (game) {
    super(game)
    this.appId = game.appId
    this.steamUserName = game.steamUserName
    this.steamPassword = game.steamPassword
  }

  install () {
    this.steamUserName = 'anonymous'
    this.steamPassword = ''
    const steamLogin = `+login ${this.steamUserName} ${this.steamPassword}`
    const installCmd = `steamcmd ${steamLogin} +force_install_dir ${this.path} +app_update ${this.appId} validate +quit`

    super.install(this)
    super.createUnitFile(this)
    super.createLaunchScript(`${this.launchParams}`)

    if (this.dryrun) {
      console.log(Chalk.yellow('Dryrun mode enabled -- Creating files & folders only.'))
      return
    }
    enableLogging(this.path, this.name)
    execSync(installCmd)
  }
}

module.exports = SteamCmd
