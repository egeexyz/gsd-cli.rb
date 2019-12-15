GameServer   = require("../server_builder")
{ execSync } = require("child_process")

class Tf2
  @install: (flags) ->
    super(flags)
    return "Install Complete!"
  @createUnitFile: (flags) ->
    super(flags)
  @createLaunchScript: (flags) ->
    super(flags)
  @createLogFile: (flags) ->
    super(flags)
  @backupFile: (file) ->
    super(file)
module.exports = Tf2
