app = require('express')()
kraken = require 'kraken-js'
options = require('./lib/spec')(app)
port = process.env.PORT || 8000

app.use kraken(options)

app.listen port,()->
    console.log 'application is listen on ' + port
