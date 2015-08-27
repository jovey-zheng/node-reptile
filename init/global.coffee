path = require 'path'

global.__basename = path.normalize __dirname + '/..'

#development
global.kill = (msg) ->
  console.log msg
  process.exit();

global.print = (msg) ->
  console.log msg
