const { exec } = require('child_process')
const fsAsync = require('fs')
const fs = fsAsync.promises

const srcdsPostInstall = (game) => {
  enableLogging(game)
}

const enableLogging = async (game) => {
  const logFilePath = `${game.path}/${game.name}`
  let launchScript = await fs.readFile(`${game.path}/launch.sh`, 'utf8')
  exec(`mkdir -p ${logFilePath}`)
  exec(`touch ${logFilePath}/console.log`)

  launchScript = `${launchScript}/usr/bin/tail -f ${logFilePath}/console.log`
  fs.writeFile(`${game.path}/launch.sh`, launchScript)
}

module.exports = srcdsPostInstall
