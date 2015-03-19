controllers = require '../controllers'

module.exports = (router) ->
    router.get '/', controllers.index
