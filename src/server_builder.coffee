Chalk           = require("chalk")
RustServer     = require("./games/rust")
SdtdServer     = require("./games/sdtd")
SrcdsServer     = require("./games/srcds")
MinecraftServer = require("./games/minecraft")

class GameServer
  @install: (flags) ->
    switch flags.config.meta.game
      when "minecraft"
        MinecraftServer.install(flags)
      when "rust"
        RustServer.install(flags)
      when "garrysmod"
        SrcdsServer.install(flags)
      when "tf"
        SrcdsServer.install(flags)
      when "sdtd"
        SdtdServer.install(flags)
      else console.warn "That game isn't supported yet"
    console.info(Chalk.green.bold("Installation of #{flags.config.meta.game} complete! 🚀"))

module.exports = GameServer
