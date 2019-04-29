# frozen_string_literal: true

module Helpers
  def self.remote_cmd(connection, command)
    system("ssh #{connection} '#{command}'")
  end

  def self.steamcmd_exists?(path = "/usr/games/steamcmd", binary = "steamcmd")
    if system("stat #{path}")
      true
    elsif system("which #{binary}")
      true
    else
      false
    end
  end
end
