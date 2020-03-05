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
    if (game.steamPassword) {
      this.steamUserName = game.steamUserName
      this.steamPassword = game.steamPassword
    } else {
      this.steamUserName = 'anonymous'
      this.steamPassword = ''
    }
  }

  install () {
    const steamLogin = `+login ${this.steamUserName} ${this.steamPassword}`
    const installCmd = `steamcmd ${steamLogin} +force_install_dir ${this.path} +app_update ${this.appId} validate +quit`

    super.createDirectories()
    super.createUnitFile()
    super.createLaunchScript()

    if (this.dryrun) {
      console.log(Chalk.yellow('Dryrun mode enabled -- Creating files & folders only.'))
      return
    }
    console.info(Chalk.blue.bold('Installing, please wait... ⏳'))
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
