const Chalk = require('chalk')
const { execSync } = require('child_process')

class BaseServer {
  static install (game) {
    console.info(Chalk.blue.bold('Installing, please wait... ⏳'))
    execSync(`mkdir -p /home/${game.user}/${game.name}-server`)
  }

  static createUnitFile (game) {
    const unitPath = `/home/${game.user}/.config/systemd/user/${game.name}.service`
    const unitFileContents = `[Unit]\nAfter=network.target\nDescription=Daemon for ${game.name} dedicated server\n[Install]\nWantedBy=default.target\n[Service]\nType=simple\nWorkingDirectory=${game.path}\nExecStart=/bin/bash ${game.path}/launch.sh`
    execSync(`rm -f ${unitPath}`)
    execSync(`touch ${unitPath}`)
    return execSync(`echo '${unitFileContents}' >> ${unitPath}`)
  }

  static createLaunchScript (game, launchFileContents) {
    const launchFilePath = `${game.path}/launch.sh`
    this.backupFile(launchFilePath)
    execSync(`rm -f ${launchFilePath}`)
    execSync(`touch ${launchFilePath}`)
    execSync(`echo '${launchFileContents}' >> ${launchFilePath}`)
    return execSync(`chmod +x ${launchFilePath}`)
  }

  static createLogFile (game) {
    return execSync(`touch ${game.path}/console.log`)
  }

  static backupFile (file) {
    execSync(`touch ${file}`)
    execSync(`rm -f ${file}.backup`)
    return execSync(`mv ${file} ${file}.backup`)
  }
}

module.exports = BaseServer
