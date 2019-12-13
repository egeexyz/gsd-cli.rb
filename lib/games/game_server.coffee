
class GameServer
  @install: (flags) ->
    switch flags.name
      when "rust" then return "Installing, please wait"
      else return "That game isn't supported yet"

module.exports = GameServer
