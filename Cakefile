{ exec, spawn } = require 'child_process'

build = () ->
  exec 'coffee --compile --map --output dist/ src/'

clean = () ->
  exec 'rm -rf dist/*'
  exec 'touch dist/.gitkeep'

task 'build', 'Description of task', ->
  build()

task 'rebuild', 'Description of task', ->
  build()
  clean()

task 'clean', 'Description of task', ->
  clean()

