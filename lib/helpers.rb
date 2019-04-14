# frozen_string_literal: true

module Helpers
  def self.remote_cmd(connection, command)
    system("ssh #{connection} '#{command}'")
  end
end
