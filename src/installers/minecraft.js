const { execSync } = require('child_process')
const BaseInstaller = require('./base')
const Chalk = require('chalk')
const fsAsync = require('fs')
const fs = fsAsync.promises

class Minecraft extends BaseInstaller {
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
    this.buildSpigot()
    this.addJar()
  }

  buildSpigot () {
    console.info(Chalk.blue.bold(`Building Spigot ${this.version}, this will take a while... ⏳`))
    this.downloadBuildTools(this.path)
    console.log(execSync('java -Xmx1024M -jar BuildTools.jar --nogui', { cwd: this.path }).toString())
  }

  async addJar () {
    const launchScript = await fs.readFile(`${this.path}/launch.sh`, 'utf8')
    await fs.writeFile(`${this.path}/launch.sh`, `${launchScript}-jar ${this.path}/spigot-${this.version}.jar`)
  }

  downloadBuildTools (path) {
    execSync(`wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar -O ${path}/BuildTools.jar`)
  }
}

module.exports = Minecraft
