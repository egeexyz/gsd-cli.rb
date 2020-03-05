const Chalk = require('chalk')
const BaseInstaller = require('./base')
const { execSync } = require('child_process')
const { enableLogging } = require('./backends/srcds')
const { downloadMultiAdmin } = require('./backends/scp')

class SteamCmd extends BaseInstaller {
  constructor (game) {
    super(game)
    this.appId = game.appId
    this.backend = game.backend
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
    execSync(installCmd)
    this.postInstall()
  }

  postInstall () {
    switch (this.backend) {
      case 'srcds':
        enableLogging(this.path, this.name)
        break
      case 'scp':
        downloadMultiAdmin(this.path)
        break
    }
  }
}

module.exports = SteamCmd
