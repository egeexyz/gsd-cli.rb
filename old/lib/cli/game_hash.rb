require "servers/gmod"
require "servers/rust"
require "servers/terraria"
require "servers/starbound"
require "servers/seven_days"
require "servers/team_fortress"
require "servers/minecraft_ftb"
require "servers/minecraft_spigot"
require "servers/ace_of_spades"

def game_hash
  {
    "rust" => Rust.new,
    "sdtd" => SevenDays.new,
    "gmod" => GarrysMod.new,
    "aos" => AceOfSpades.new,
    "tf2" => TeamFortress.new,
    "ftb" => MinecraftFtb.new,
    "terraria" => Terraria.new,
    "starbound" => Starbound.new,
    "minecraft" => MinecraftSpigot.new
  }
end
