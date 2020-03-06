# gsd-cli v2 [![Build Status](https://travis-ci.org/egee-irl/gsd-cli.svg?branch=master)](https://travis-ci.org/egee-irl/gsd-cli)

[![oclif](https://img.shields.io/badge/cli-oclif-brightgreen.svg)](https://oclif.io)
[![Discord](https://discordapp.com/api/guilds/183740337976508416/widget.png?style=shield)](https://discord.gg/EMbcgR8)

A CLI tool for deploying dedicated game servers as systemd units (daemons).

This repo is for gsd-cli version 2.x. This version of the cli is written in CoffeeScript and can be downloaded as a global module from [npm](https://www.npmjs.com/package/gsd-cli).

gsd-cli installs dedicated server as _user_ daemons managed by systemd, a Linux system & service manager.

You can interact with systemd services using the `systemctl` and `journalctl` commands. Since the cli installs dedicated servers as _user_ daemons, always include the `--user` flag when interacting with systemd.

For example:  `systemctl --user restart minecraft`.

You can read the log files for a given server using the `journalctl` command. For example, to follow a Minecraft server's log:

`systemctl --user -fu minecraft`

All game servers are created in `/home/your_user/whatever-server`. For example, a minecraft server would look like this:

`/home/egee/minecraft-server`.

The dedicated servers themselves are spawned from a shell `launch.sh` script script located in the dedicated server's install path. This file is created by the cli from the config file passed to it during install time and is safe to edit after installing a server. For example, the launch script for a Rust server is located:

`/home/egee/rust-server/launch.sh`

User-level systemd unit files are located in `~/.config/systemd/user`. You can [specify](https://www.freedesktop.org/software/systemd/man/systemd.resource-control.html#) the amount of system resources available to the server by adding properties to the `.service` file if you desire.

Currently supported game servers:

* minecraft
* rust
* 7 days to die[sdtd]
* garry's mod[gmod]
* team fortress 2[tf2]

## Usage
<!-- usage -->
```sh-session
$ npm install -g gsd-cli
$ gsd-cli COMMAND
running command...
$ gsd-cli (-v|--version|version)
gsd-cli/1.3.5 linux-x64 node-v12.13.0
$ gsd-cli --help [COMMAND]
USAGE
  $ gsd-cli COMMAND
...
```
<!-- usagestop -->
## Commands
<!-- commands -->
* [`gsd-cli help [COMMAND]`](#gsd-cli-help-command)
* [`gsd-cli install`](#gsd-cli-install)

## `gsd-cli help [COMMAND]`

display help for gsd-cli

```
USAGE
  $ gsd-cli help [COMMAND]

ARGUMENTS
  COMMAND  command to show help for

OPTIONS
  --all  see all commands in CLI
```

_See code: [@oclif/plugin-help](https://github.com/oclif/plugin-help/blob/v2.2.2/src/commands/help.ts)_

## `gsd-cli install`

Installs a dedicated game server using a config file or a name with default settings.

```
USAGE
  $ gsd-cli install

OPTIONS
  -d, --dryrun     test installing a server without actually installing it
  -f, --file=file  path to the config file
  -n, --name=name  name of the server to install
```

_See code: [src/commands/install.js](https://github.com/Egeeio/gsd-cli/blob/v1.3.5/src/commands/install.js)_
<!-- commandsstop -->
