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
