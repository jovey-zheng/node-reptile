url = require 'url'

tarUrl = 'http://segmentfault.com'

module.exports =
  parser: 'forum'
  websiteName: 'SegmentFault'
  zone: 'zh'
  lang: 'cn'
  area:
    list:[
      name: '最新的'
      url: 'http://segmentfault.com/questions/newest'
    ,
      name: '热门的'
      url: 'http://segmentfault.com/questions/hottest'
    ,
      name: '未回答'
      url: 'http://segmentfault.com/questions/unanswered'
    ]
  topic:
    titleFn: ($l) ->
      $l.find('.summary .title a').text()
    urlFn: ($l) ->
      href = $l.attr('href')
      url.resolve tarUrl, href or ''
  post:
    authorFn: ($l) ->
      $l.find('#questionTitle a').text()
    contentFn: ($l) ->
      $l.find('.post-offset .question').html()
