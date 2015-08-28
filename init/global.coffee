path = require 'path'
moment = require 'moment'

global.__basename = path.normalize __dirname + '/..'

#development
global.kill = (msg) ->
  console.log msg
  process.exit();

global.print = (msg) ->
  console.log msg

global.log = (msg)->
  console.log "#{moment().format('YYYY-MM-DD HH:mm:ss')} - #{message}"
