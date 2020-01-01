{ execSync } = require 'child_process'
install      = require("../dist/commands/install")
assert       = require('assert')

describe 'supported games', ->
  it "should support Garrys Mod", ->
    filePath = execSync("readlink -f ./configs/gmod.json")
    sdout = execSync("node ./bin/run install -d -f #{filePath}")
    assert.ok(sdout.includes("Installing, please wait"))
  it "should support Team Fortress 2", ->
    filePath = execSync("readlink -f ./configs/tf2.json")
    sdout = execSync("node ./bin/run install -d -f #{filePath}")
    assert.ok(sdout.includes("Installing, please wait"))
  it "should support Minecraft", ->
    filePath = execSync("readlink -f ./configs/minecraft.json")
    sdout = execSync("node ./bin/run install -d -f #{filePath}")
    assert.ok(sdout.includes("Installing, please wait"))
  it "should support Rust", ->
    filePath = execSync("readlink -f ./configs/rust.json")
    sdout = execSync("node ./bin/run install -d -f #{filePath}")
    assert.ok(sdout.includes("Installing, please wait"))
  it "should support 7 Days To Die", ->
    filePath = execSync("readlink -f ./configs/sdtd.json")
    sdout = execSync("node ./bin/run install -d -f #{filePath}")
    assert.ok(sdout.includes("Installing, please wait"))

describe 'installation process', ->
  game = "garrysmod"
  script = "./srcds_run -console -game #{game} +map gm_construct +maxplayers 16 +host_workshop_collection 1838303608 -condebug & /usr/bin/tail -f ./console.log"
  execSync("mkdir -p /home/#{process.env.USER}/.config/systemd/user")

  it "should create a log file", ->
    backupScriptContents = execSync("cat /home/#{process.env.USER}/#{game}-server/#{game}/console.log")
    assert.ok(!backupScriptContents.includes('No such file or directory'))

  it "should create a systemd unit file", ->
    unitFileContents = execSync("cat /home/#{process.env.USER}/.config/systemd/user/#{game}.service")
    assert.ok(unitFileContents.includes('garrysmod-server'))

  it "should create a launch script", ->
    launchScriptContents = execSync("cat /home/#{process.env.USER}/#{game}-server/launch.sh")
    assert.ok(launchScriptContents.includes("#{game}"))

  it "should backup the launch script", ->
    backupScriptContents = execSync("cat /home/#{process.env.USER}/#{game}-server/launch.sh.backup")
    assert.ok(!backupScriptContents.includes('No such file or directory'))

  it "should not duplicate launch script", ->
    launchScriptContents = execSync("cat /home/#{process.env.USER}/#{game}-server/launch.sh")
    assert.ok(launchScriptContents.toString().match(/-game garrysmod/gm).length == 1)
