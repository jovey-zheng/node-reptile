cheerio = require 'cheerio'
url = require 'url'
superagent = require 'superagent'

module.exports = ->
  getTopic()

getTopic = ->
  _tarUrl = 'http://segmentfault.com'
  superagent.get _tarUrl
  .end (err, res) ->
    # console.log res
    if err then console.error errdd
    $ = cheerio.load res.text

    $ '.summary .title a'
    .each (idx, element) ->
      content = element.children[0].data
      aLink = element.attribs.href
      href = url.resolve _tarUrl, aLink

      # console.log element.children[0].data
      # console.log href
      # console.log ''
      printText content
      printText href

printText = (text) ->
  console.log text
