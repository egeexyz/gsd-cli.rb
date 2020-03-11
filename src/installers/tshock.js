const { execSync } = require('child_process')
const BaseInstaller = require('./base')
const Chalk = require('chalk')
const fsAsync = require('fs')
const fs = fsAsync.promises

class TShock extends BaseInstaller {
  constructor (game) {
    super(game)
    this.version = game.version
  }

  install () {
    super.createDirectories()
    super.createUnitFile()
    super.createLaunchScript()

    if (this.dryrun) {
      console.log(Chalk.yellow('Dryrun mode enabled -- Creating files & folders only.'))
      return
    }
    this.downloadTshock()
    this.createConfigFile()
  }

  async createConfigFile () {
    const launchScript = await fs.readFile(`${this.path}/launch.sh`, 'utf8')
    await fs.writeFile(`${this.path}/launch.cfg`, `maxplayers=8\nworldpath=${this.path}/worlds\nworld=${this.path}/worlds/world01.wld\nport=7777\npassword=_\nautocreate=1\ndifficulty=0\nworldname=YEET`)
  }

  downloadTshock () {
    execSync(`wget https://github.com/Pryaxis/TShock/releases/download/v${this.version}/tshock_${this.version}.zip -O ${this.path}/tshock.zip`)
    execSync('unzip -u tshock.zip', { cwd: this.path })
  }
}

module.exports = TShock
