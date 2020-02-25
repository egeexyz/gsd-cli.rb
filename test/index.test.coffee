{ execSync } = require 'child_process'
assert       = require 'assert'

describe 'gsd-cli api', ->
  describe 'gsd-cli install', ->
    it 'should include an Install command', ->
      api = execSync('node ./bin/run')
      assert.ok api.includes 'install'
    it 'should not allow -f and -n flags together', ->
      api = execSync('node ./bin/run install -n rust -f ./rust.json')
      assert.ok api.includes 'Use one or the other'
  describe 'gsd-cli update', ->
    it 'should include an Update command', ->
      api = execSync('node ./bin/run')
      assert.ok api.includes 'update'
