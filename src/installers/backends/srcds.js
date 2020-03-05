const { execSync, exec } = require('child_process')

const enableLogging = (installPath, gameName) => {
  const logFilePath = `${installPath}/${gameName}`
  exec(`mkdir -p ${logFilePath}`)
  exec(`touch ${logFilePath}/console.log`)
  exec(`echo '& /usr/bin/tail -f ${logFilePath}/console.log' >> ${installPath}/launch.sh`)
}

module.exports = { enableLogging }
