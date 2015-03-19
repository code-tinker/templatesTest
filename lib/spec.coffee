path = require 'path'
module.exports = (app) ->
    {
    onconfig : (config,next) ->
        console.log config.get('databaseConfig')
        next(null,config)
    }
