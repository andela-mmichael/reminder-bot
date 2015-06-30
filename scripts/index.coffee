_         = require 'lodash'

module.exports = (robot) ->
  
  robot.respond /(.*)information?/i, (msg) ->
    msg.send "Nothing to see here.."

  robot.respond /help/i, (msg) ->
    commands = _.template(
      "`information`  - Introduces self"
    );

    msg.send commands()