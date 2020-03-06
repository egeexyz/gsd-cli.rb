const Chalk = require('chalk')
const BaseInstaller = require('./base')
const { execSync } = require('child_process')
const unityPostInstall = require('./backends/unity')
const srcdsPostInstall = require('./backends/srcds')
const scpPostInstall = require('./backends/scp')

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
        srcdsPostInstall(this)
        break
      case 'scp':
        scpPostInstall(this)
        break
      case 'unity':
        unityPostInstall(this)
        break
    }
  }
}

module.exports = SteamCmd
