{ execSync } = require 'child_process'
assert       = require('assert')

describe 'gsd-cli api', ->
  it 'should include an Install command', ->
    api = execSync('node ./bin/run')
    assert.ok api.includes 'install'
  it 'should include an Update command', ->
    api = execSync('node ./bin/run')
    assert.ok api.includes 'update'
