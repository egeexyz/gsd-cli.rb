# gsd-cli [![CircleCI](https://circleci.com/gh/Egeeio/gsd-cli.svg?style=svg)](https://circleci.com/gh/Egeeio/gsd-cli)

[![Maintainability](https://api.codeclimate.com/v1/badges/004676926e67e920ef77/maintainability)](https://codeclimate.com/github/Egeeio/gsd-cli/maintainability)
[![Discord](https://discordapp.com/api/guilds/183740337976508416/widget.png?style=shield)](https://discord.gg/EMbcgR8)

gsd-cli (Game Server Daemon) is a cli tool for deploying dedicated game servers as systemd units (daemons) on Linux.

## Installation

gsd-cli is designed to be installed as a Ruby Gem [![Gem Version](https://badge.fury.io/rb/gsd-cli.svg)](https://badge.fury.io/rb/gsd-cli) and executed from the terminal like any CLI application.  Examples:

`gsd status tf2` is _roughly_ equivilent to `systemctl status tf2`

`gsd restart rust` is _roughly_ equivilent to `systemctl restart rust`

Install gsd-cli on your favorite Linux machine with the following command: `gem install gsd-cli`

**Limitation:** Since the game servers are installed as systemd daemons, `root` is required to complete the initial installation. This will be fixed in a future version.

## Usage

gsd-cli is a pretty standard [Commander](https://github.com/commander-rb/commander)-based cli. All commands have built-in `--help` functions. Game servers are installed as systemd units and gsd provides a thin wrapper around common systemd functions.

If you want to install a game server, you'd run `gsd install minecraft --path /opt/minecraft`. You'll want to replace `minecraft` with one of these game servers that are currently supported:

* 7 Days to Die
* Garrys Mod
* Minecraft
* Rust
* Team Fortress 2
