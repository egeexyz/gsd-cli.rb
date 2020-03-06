const { exec } = require('child_process')

const scpPostInstall = (game) => {
  downloadMultiAdmin(game.path)
}

const downloadMultiAdmin = (path) => {
  exec(`wget https://github.com/Grover-c13/MultiAdmin/releases/download/3.2.5/MultiAdmin.exe -O ${path}/MultiAdmin.exe`)
}

module.exports = scpPostInstall
