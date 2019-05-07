# gsd-cli

[![Gem Version](https://badge.fury.io/rb/gsd-cli.svg)](https://badge.fury.io/rb/gsd-cli)
[![Maintainability](https://api.codeclimate.com/v1/badges/004676926e67e920ef77/maintainability)](https://codeclimate.com/github/Egeeio/gsd-cli/maintainability)
[![Discord](https://discordapp.com/api/guilds/183740337976508416/widget.png?style=shield)](https://discord.gg/tVyBHAU)
[![CircleCI](https://circleci.com/gh/Egeeio/gsd-cli.svg?style=svg)](https://circleci.com/gh/Egeeio/gsd-cli)

gsd (Game Server Daemon) is a cli tool for deploying dedicated game servers as systemd units (daemons) on Linux.

## Usage

gsd is a pretty standard [Commander](https://github.com/commander-rb/commander)-based cli. All commands have built-in `--help` functions. Game servers are installed as systemd units and gsd provides a thin wrapper around common systemd functions. Examples:

`gsd status tf2` is _roughly_ equivilent to `systemctl status tf2`

`gsd restart rust` is _roughly_ equivilent to `systemctl restart rust`
