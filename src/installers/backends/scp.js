const { execSync } = require('child_process')

const downloadMultiAdmin = (path) => {
  execSync(`wget https://github.com/Grover-c13/MultiAdmin/releases/download/3.2.5/MultiAdmin.exe -O ${path}/MultiAdmin.exe`)
}

module.exports = { downloadMultiAdmin }
