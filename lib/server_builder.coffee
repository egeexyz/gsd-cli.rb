Gmod = require("./games/gmod")
Tf2 = require("./games/tf2")

class GameServer
  @install: (flags) ->
    switch flags.name
      # when "minecraft" then return "Installing, please wait"
      # when "rust" then return "Installing, please wait"
      when "gmod"
        flags.internal_name = "garrysmod"
        flags.app_id        = "4020"
        flags.steam_login   = "anonymous"
        flags.collection_id = "1838303608"
        flags.map           = "gm_construct"
        flags.players       = "16"
        Gmod.install(flags)
      when "tf2"
        flags.internal_name = "tf"
        flags.app_id        = "232250"
        flags.steam_login   = "anonymous"
        flags.map           = "ctf_turbine"
        flags.players       = "24"
        Tf2.install(flags)
      # when "sdtd" then return "Installing, please wait"
      else return "That game isn't supported yet"

module.exports = GameServer
