const { execSync, exec } = require('child_process')

const enableLogging = (installPath, gameName) => {
  const logFilePath = `${installPath}/${gameName}/console.log`
  exec(`mkdir -p ${logFilePath}`)
  exec(`touch ${logFilePath}`)
  exec(`echo '& /usr/bin/tail -f ${installPath}/${installPath}/console.log' >> ${installPath}/launch.sh`)
}

module.exports = { enableLogging }
