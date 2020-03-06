const fsAsync = require('fs')
const fs = fsAsync.promises

const srcdsPostInstall = (game) => {
  enableLogging(game)
}

const enableLogging = async (game) => {
  let launchScript = await fs.readFile(`${game.path}/launch.sh`, 'utf8')
  await fs.writeFile(`${game.path}/${game.name}/console.log`, '')

  launchScript = `${launchScript}/usr/bin/tail -f ${game.path}/${game.name}/console.log`
  fs.writeFile(`${game.path}/launch.sh`, launchScript)
}

module.exports = srcdsPostInstall
