_      = require('lodash')
needle = require('needle')

SLACK_URL = 'https://slack.com/api/'
SLACK_TOKEN = 'xoxp-2853699384-3890252498-7040805602-8eb806'

mapUsers = (robot, cb) ->
  url = SLACK_URL + 'users.list' + '?token=' + SLACK_TOKEN
  needle.get url, (err, res) ->
    if err
      console.log err
    else
      slackUsers = {}
      users = res.body.members
      _.forEach users, (user) ->
        slackUsers[user.id] = _.pick(user, 'id', 'name')
      robot.brain.set 'slackUsers', slackUsers

mapChannels = (robot, cb) ->
  url = SLACK_URL + 'channels.list' + '?token=' + SLACK_TOKEN
  needle.get url, (err, res) ->
    if err
      console.log err
    else
      slackChannels = {}
      channels = res.body.channels
      _.forEach channels, (channel) ->
        slackChannels[channel.name] = _.pick(channel, 'id','name','members')
      robot.brain.set 'slackChannels', slackChannels

module.exports = (robot) ->
  setTimeout (->
    mapUsers(robot)
    mapChannels(robot)
  ), 10000