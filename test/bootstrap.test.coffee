assert       = require('assert')
install      = require("../dist/commands/bootstrap")
{ execSync } = require 'child_process'

describe 'bootstrap game server', ->
