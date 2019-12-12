install = require("../dist/commands/install")
launch = require("../dist/commands/launch")
update = require("../dist/commands/update")
assert = require('assert')

describe('Array', ->
  describe('#indexOf()', ->
    it('should return -1 when the value is not present', ->
      assert.equal([1, 2, 3].indexOf(4), -1))
  )
)