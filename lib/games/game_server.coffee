Gmod = require("./gmod")

class GameServer
  @install: (flags) ->
    switch flags.name
      # when "minecraft" then return "Installing, please wait"
      # when "rust" then return "Installing, please wait"
      when "gmod"
        flags.app_id        = "4020"
        flags.steam_login   = "anonymous"
        flags.collection_id = "1838303608"
        Gmod.install(flags)
      # when "tf2" then return "Installing, please wait"
      # when "sdtd" then return "Installing, please wait"
      else return "That game isn't supported yet"

module.exports = GameServer
