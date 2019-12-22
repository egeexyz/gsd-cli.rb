Chalk           = require("chalk")
SrcdsServer     = require("./games/srcds")
MinecraftServer = require("./games/minecraft")

class GameServer
  @install: (flags) ->
    switch flags.config.meta.game
      when "minecraft"
        flags.version     = "1.15.1"
        flags.installPath = "/home/#{process.env.USER}/#{flags.name}-server"
        flags.javaExec    = "java -Xmx1024M -jar BuildTools.jar --rev #{flags.version}"
        MinecraftServer.install(flags)
      # when "rust" then return "Installing, please wait"
      when "garrysmod"
        SrcdsServer.install(flags)
      when "tf"
        SrcdsServer.install(flags)
      # when "sdtd" then return "Installing, please wait"
      else console.warn "That game isn't supported yet"
    console.info(Chalk.green.bold("Installation of #{flags.config.meta.game} complete! 🚀"))

module.exports = GameServer
