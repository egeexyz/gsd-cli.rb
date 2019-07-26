# frozen_string_literal: true

require "commander/import"

program :name, "gsd-cli"
program :version, "0.1.33"
program :description, "A cli tool to deploy & manage dedicated game servers on Linux"

require "cli/install"
require "cli/update"
require "cli/run"
