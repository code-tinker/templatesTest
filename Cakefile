{spawn,exec} = require 'child_process'
which = require 'which'
async = require 'async'

green = '\x1B[0;32m'
reset = '\x1B[0m'

log = (message,color,explanation) ->
    console.log color + message + reset + ' ' + (explanation or '')

build = (callback) ->
    async.parallel {
        copyFile : (next) ->
            # move all the file to .app except coffee file
            cmd = which.sync 'rsync'
            options = ['-qr','./','.app','--exclude=*.coffee','--exclude=.app']
            copy = spawn cmd,options
            copy.stdout.pipe process.stdout
            copy.stderr.pipe process.stderr
            copy.on 'exit',(status) -> next null,status
        ,
        compile : (next) ->
            options = ['-c','-b','-o','.app','./']
            cmd = which.sync 'coffee'
            coffee = spawn cmd, options
            coffee.stdout.pipe process.stdout
            coffee.stderr.pipe process.stderr
            coffee.on 'exit',(status) -> next null,status
    },(err,results)->
        if err
            console.log err
        else 
            if results.copyFile == 0 and results.compile == 0
                log 'build success',green
                callback?()

task 'build', ->
    build -> log ":)", green

task 'dev', 'start dev env', ->
    # watch_coffee
    options = ['-c','-b','-w','-o','.app','./']
    cmd = which.sync 'coffee'
    coffee = spawn cmd, options
    coffee.stdout.pipe process.stdout
    coffee.stderr.pipe process.stderr
    log 'Watching coffee files', green

task 'debug', 'start debug env', ->

    options = ['-c','-b','-w','-o','.app','src']
    cmd = which.sync 'coffee'
    coffee = spawn cmd, options
    coffee.stdout.pipe process.stdout
    coffee.stderr.pipe process.stderr
    log 'Watching coffee files', green

    # run debug mode
    app = spawn 'node', [
        '--debug',
        'server'
    ]
    app.stdout.pipe process.stdout
    app.stderr.pipe process.stderr
    # run node-inspector
    inspector = spawn 'node-inspector'
    inspector.stdout.pipe process.stdout
    inspector.stderr.pipe process.stderr
    # tell the user to open the chrome
    exec 'hostname -i', (err,stdout,stderr) ->
        ip = '127.0.0.1'
        ip = stdout.replace /\s$/, '' if !err
        console.log 'open chrome and debug by visit: http://' + ip + ':8080/debug?port=5858'
