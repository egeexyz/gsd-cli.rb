Chalk           = require("chalk")
SrcdsServer     = require("./games/srcds")
MinecraftServer = require("./games/minecraft")

class GameServer
  @install: (flags) ->
    switch flags.name
      when "minecraft"
        flags.version     = "1.15.1"
        flags.installPath = "/home/#{process.env.USER}/#{flags.name}-server"
        flags.javaExec    = "java -Xmx1024M -jar BuildTools.jar --rev #{flags.version}"
        MinecraftServer.install(flags)
      # when "rust" then return "Installing, please wait"
      when "gmod"
        flags.internal_name = "garrysmod"
        flags.app_id        = "4020"
        flags.steam_login   = "anonymous"
        flags.map           = "gm_construct"
        flags.players       = "16"
        flags.custom_params = "+host_workshop_collection 1838303608"
        SrcdsServer.install(flags)
      when "tf2"
        flags.internal_name = "tf"
        flags.app_id        = "232250"
        flags.steam_login   = "anonymous"
        flags.map           = "ctf_turbine"
        flags.players       = "24"
        flags.custom_params = "+sv_pure 1"
        SrcdsServer.install(flags)
      # when "sdtd" then return "Installing, please wait"
      else console.warn "That game isn't supported yet"
    console.info(Chalk.green.bold("Installation of #{flags.name} complete! 🚀"))

module.exports = GameServer
