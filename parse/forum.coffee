cheerio = require 'cheerio'
url = require 'url'
superagent = require 'superagent'
fs = require 'fs'
Q = require 'q'
iconv = require 'iconv-lite'

Entities = require 'html-entities'
Entities = Entities.XmlEntities

module.exports = (url)->
  getTopic(url)

  # setInterval ->
  #   getTopic()
  # , 1000 * 60
  # getTopic()
  # 每隔一分钟重新获取

getTopic = (_tarUrl)->
  superagent.get _tarUrl
    .end (err, res) ->
      if err then console.error err
      $ = cheerio.load res.text

      $ '.summary .title a'
      .each (idx, element) ->
        content = element.children[0].data
        aLink = element.attribs.href
        href = url.resolve _tarUrl, aLink

        Q href
        .then parseTopic
        .then (result) ->
          print result


parseTopic = (options) ->
  Q()
  .then superagent.get(options).end (err, res) ->
    $ = cheerio.load res.text,
      decodeEntities: false

    #title
    print $('#questionTitle a').text()
    #author
    # print $('.author strong').text()
    #content
    questions =  $('.post-offset .question').html()
    # entities = new Entities()
    # kill entities.decode questions
    # kill questions

    data =
      title: $('#questionTitle a').text()
      author: $('.author strong').text()
      question: $('.post-offset .question').html()

    # print data
    # fs.appendFile 'log.txt', data.question, (err) ->
    #   if err then print err
    #   print 'write finished..'

