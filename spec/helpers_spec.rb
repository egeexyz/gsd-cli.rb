# frozen_string_literal: true

require "./lib/helpers"

RSpec.describe "Helpers" do
  context "steamcmd_exists?" do
    it "returns false if steamcmd is not installed" do
      steamcmd_installed = Helpers.steamcmd_exists?("/sbin/steamcmd", "not_steamcmd")
      expect(steamcmd_installed).to be false
    end
    it "returns true if steamcmd is in the path" do
      steamcmd_installed = Helpers.steamcmd_exists?("/sbin/steamcmd")
      expect(steamcmd_installed).to be true
    end
    it "returns true if steamcmd is installed" do
      steamcmd_installed = Helpers.steamcmd_exists?
      expect(steamcmd_installed).to be true
    end
  end
end
