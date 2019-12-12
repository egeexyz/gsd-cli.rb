{ exec } = require 'child_process'

task 'build', 'Description of task', ->
  exec 'coffee --compile --map --output dist/ lib/'

task 'rebuild', 'Description of task', ->
  console.log 'Hello World!'

task 'start', 'Description of task', ->
  console.log 'Hello World!'

task 'restart', 'Description of task', ->
  console.log 'Hello World!'

task 'clean', 'Description of task', ->
  exec 'rm -rf dist/*'
  exec 'touch dist/.gitkeep'

