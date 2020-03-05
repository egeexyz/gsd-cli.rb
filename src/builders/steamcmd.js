const Chalk = require('chalk')
const BaseServer = require('./base')
const { execSync, exec } = require('child_process')

class SteamCmdServer extends BaseServer {
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
    super.createLaunchScript(`${this.launchParams} & /usr/bin/tail -f ${this.path}/${this.name}/console.log`)
    exec(`mkdir -p ${this.path}/${this.name}`)
    exec(`touch ${this.path}/${this.name}/console.log`)
    if (this.dryrun) {
      console.log(Chalk.yellow('Dryrun mode enabled -- Creating files & folders only.'))
      return
    }
    execSync(installCmd)
    this.snowflakes(this.name)
  }

  snowflakes (name) {
    switch (name) {
      case 'scp':
        execSync(`wget https://github.com/Grover-c13/MultiAdmin/releases/download/3.2.5/MultiAdmin.exe -O ${this.path}/MultiAdmin.exe`)
        break
    }
  }
}

module.exports = SteamCmdServer
