# frozen_string_literal: true

#TODOs:
#1) Implement friendly-name attribute
#2) Add tests for cli functions
#3) Implement update for Minecraft (oof)
#4) Implement ufw rules for game server objects

require "commander/import"

program :name, "gsd-cli"
program :version, "1.0.0"
program :description, "A cli tool to deploy & manage dedicated game servers on Linux"

require "cli/install"
require "cli/update"
require "cli/run"
