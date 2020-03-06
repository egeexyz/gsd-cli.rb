const { execSync } = require('child_process')

class BaseInstaller {
  constructor (game) {
    this.user = game.user
    this.name = game.name
    this.path = game.path
    this.dryrun = game.dryrun
    this.launchParams = game.launchParams
  }

  createDirectories () {
    execSync(`mkdir -p /home/${this.user}/${this.name}-server`)
    execSync(`mkdir -p /home/${this.user}/.config/systemd/user`)
  }

  createUnitFile () {
    const unitPath = `/home/${this.user}/.config/systemd/user/${this.name}.service`
    const unitFileContents = `[Unit]\nAfter=network.target\nDescription=Daemon for ${this.name} dedicated server\n[Install]\nWantedBy=default.target\n[Service]\nType=simple\nWorkingDirectory=${this.path}\nExecStart=/bin/bash ${this.path}/launch.sh`
    execSync(`rm -f ${unitPath}`)
    execSync(`touch ${unitPath}`)
    execSync(`echo '${unitFileContents}' >> ${unitPath}`)
  }

  createLaunchScript () {
    const launchFilePath = `${this.path}/launch.sh`
    this.backupFile(launchFilePath)
    execSync(`rm -f ${launchFilePath}`)
    execSync(`touch ${launchFilePath}`)
    execSync(`echo '${this.launchParams}' >> ${launchFilePath}`)
    execSync(`chmod +x ${launchFilePath}`)
  }

  backupFile (file) {
    execSync(`touch ${file}`)
    execSync(`rm -f ${file}.backup`)
    execSync(`mv ${file} ${file}.backup`)
  }
}

module.exports = BaseInstaller
