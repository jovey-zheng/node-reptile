_ = require 'underscore'
glob = require 'glob'
Q = require 'q'
config = require 'config'

forum = require __basename + '/parse/forum'

module.exports = ->
  Q()
  .then ->
    getFiles()
  .then run

getFiles = ->
  filea = if _.isArray config.pathFile then config.pathFile else [config.pathFile]
  enabled = _.map filea, (file) -> __basename + "/lib/#{file}*"
  pattern = if enabled.length > 1 then "{#{enabled.join(',')}}" else enabled.join(',')
  files = glob.sync pattern

run = (files)->
  _.each files, (file) ->
    type = file.match(/\/lib\/(\w*)\//)[1]

    Q()
    .then ->
      do interval = ->
        Q().then ->
          job = require file
          job = job?() or job

          parser = require __basename + "/parse/#{job.parser}"
          parser job
          .catch print
          .then(-> log "[#{type}][finish] - [#{job.websiteName}]")
        .delay(1000 * config.delay[type])
        .done(interval)
