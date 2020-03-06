const fsAsync = require('fs')
const fs = fsAsync.promises

const unityPostInstall = async (game) => {
  let unityExport = ''
  let launchScript = await fs.readFile(`${game.path}/launch.sh`, 'utf8')
  switch (game.name) {
    case 'rust':
      unityExport = `export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${game.path}/RustDedicated_Data/Plugins/x86_64`
      break
    case 'sdtd':
      fs.writeFile(`${game.path}/console.log`, '')
      unityExport = 'export LD_LIBRARY_PATH=.'
      launchScript = `${launchScript} -configfile=${game.path}/serverconfig.xml\\\n & /usr/bin/tail -f ${game.path}/console.log`
      break
  }

  const unityLaunchScript = `${unityExport}\n${launchScript}`
  await fs.writeFile(`${game.path}/launch.sh`, unityLaunchScript)
}

module.exports = unityPostInstall
