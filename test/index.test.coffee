{ execSync } = require 'child_process'
install  = require("../dist/commands/install")
launch   = require("../dist/commands/launch")
update   = require("../dist/commands/update")
assert   = require('assert')

describe 'gsd-cli api', ->
  it 'should include an Install command', ->
    api = execSync('node ./bin/run')
    assert.ok api.includes 'install'
  it 'should include an Update command', ->
    api = execSync('node ./bin/run')
    assert.ok api.includes 'update'
  it 'should include a Launch command', ->
    api = execSync('node ./bin/run')
    assert.ok api.includes 'launch'

describe 'gsd-cli install', ->
  game = 'gmod'
  script = './srcds_run -console -game garrysmod +map gm_construct +maxplayers 16 +host_workshop_collection 1838303608 -condebug & /usr/bin/tail -f ./console.log'
  execSync("mkdir -p /home/#{process.env.USER}/.config/systemd/user")
  execSync("mkdir -p /home/#{process.env.USER}/#{game}-server")

  it "should support Garrys Mod", ->
    sdout = execSync("node ./bin/run install -d -n #{game}")
    assert.ok(sdout.includes('Installing, please wait'))

  it "should create a systemd unit file", ->
    unitFileContents = execSync("cat /home/#{process.env.USER}/.config/systemd/user/#{game}.service")
    assert.ok(unitFileContents.includes('gmod-server'))

  it "should create a launch script", ->
    launchScriptContents = execSync("cat /home/#{process.env.USER}/#{game}-server/launch.sh")
    assert.ok(launchScriptContents.includes('garrysmod'))

  it "should backup the launch script", ->
    backupScriptContents = execSync("cat /home/#{process.env.USER}/#{game}-server/launch.sh.backup")
    assert.ok(!backupScriptContents.includes('No such file or directory'))

  it "should not duplicate launch script", ->
    launchScriptContents = execSync("cat /home/#{process.env.USER}/#{game}-server/launch.sh")
    assert.ok(launchScriptContents.toString().match(/garrysmod/gm).length == 1)
