{exec} = require 'child_process'
task 'build', 'Build project from coffee/*.coffee to js/*.js', ->
  exec 'coffee --compile --output js/ coffee/', (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr

playsnakepath = '~/Dev/Heroku/snake/resources/public/js/'
task 'deploy', 'Build and move the generated js files to PlaySnakeNow repo', ->
  invoke 'build'
  exec "cp js/* #{playsnakepath}", (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr