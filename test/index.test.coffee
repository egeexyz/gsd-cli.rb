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
  it 'should include an Install command', ->
    api = execSync('node ./bin/run install -n test')
    assert.ok api.includes 'You want to install'
