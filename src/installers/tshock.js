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
    await fs.writeFile(`${this.path}/launch.cfg`, `maxplayers=8
    worldpath=/home/egee/terraria-server/worlds
    world=/home/egee/terraria-server/worlds/world01.wld
    port=7777
    password=egeeio
    autocreate=1
    difficulty=0
    worldname=YEET`)
  }

  downloadTshock () {
    execSync(`wget https://github.com/Pryaxis/TShock/releases/download/v${this.version}/tshock_${this.version}.zip -O ${this.path}/tshock.zip`)
    execSync('unzip -u tshock.zip', { cwd: this.path })
  }
}

module.exports = TShock
