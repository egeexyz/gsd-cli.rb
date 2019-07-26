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

  def self.get_install_path(path, game)
    install_path = if path.nil?
      puts "Install path was not provided: defaulting to /opt/#{game}".yellow
     "/opt/#{game}"
    else
     path
    end
    install_path
  end

  def self.get_steamcmd_login(steam_user, steam_password)
    steam_login = if steam_user.nil?
      "+login anonymous"
      else
        "+login #{steam_user} #{steam_password}"
      end
    steam_login
  end
end
