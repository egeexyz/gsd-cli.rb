# gsd-cli

This is a cli tool to deploy dedicated game server daemons on Linux systems running systemd. WSL should work fine too. Dedicated game servers are installed, configured, and deployed with the cli and managed with systemd via cli hooks.

gsd-cli is written in Ruby so you'll need the Ruby development headers (probably `ruby-dev` or `ruby-devel`), and the `bundler` gem.

Once you have the dependencies, run the command `bundle` from the repo directory.

Assuming bundler installed the required gems, you can run the cli directly from the repo directory like so `./bin/gsd --help
