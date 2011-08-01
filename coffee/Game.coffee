

drawSnakeFrame = (ctx, line1, line2) ->
  clear(ctx)
  ctx.fillStyle = '#2F2F2F'
  ctx.strokeStyle = '#C7FAD9'
  snake = []
  scale = window.grid.scale
  gridWidth = window.grid.width - 3
  gridHeight = window.grid.height - 5
  # Bottom row
  for i in [3...gridWidth]
    snake.push [i, gridHeight]

  # Top row

  for i in [1...5]
    snake.push [3 + i, 5]
    snake.push [(gridWidth - i) - 1, 5]

  # Left and right columns
  for i in [5...gridHeight]
    snake.push [3, i]
    snake.push [gridWidth - 1, i]

  snake.forEach (piece) ->
    ctx.beginPath()
    ctx.rect(piece[0] * scale, piece[1] * scale, scale, scale)
    ctx.closePath()
    ctx.fill()
    ctx.stroke()

  ctx.font = '48px Bowlby One'
  ctx.textAlign = 'center'

  # First draw the shadow
  ctx.fillStyle = 'rgba(255, 255, 255, 0.6)'
  ctx.fillText(line1, 300, 186)
  ctx.fillText(line2, 300, 256)

  # ...and then write the text
  ctx.fillStyle = '#2F2F2F'
  ctx.fillText(line1, 300, 185)
  ctx.fillText(line2, 300, 255)

displaySplashScreen = (ctx) ->
  drawSnakeFrame ctx, 'Play Snake', 'Now!'

displayGameOver = (ctx)->
  drawSnakeFrame ctx, 'Game', 'Over'


clear = (ctx) ->
  ctx.fillStyle = "#8CC09F"
  ctx.beginPath()
  ctx.rect(0, 0, c.width, c.height)
  ctx.closePath()
  ctx.fill()


updateScore = ->
  $('#playerScore').text(window.player.score)

showMenuPanel = ->
  scoreSpan = "<span>Score: #{window.player.score}</span>"
  tweetBtn = "<a id='tweetScore' href='http://twitter.com/share?
url=http%3A%2F%2Fplaysnakenow.com%2F&text=I%20have%20just%20scored%20#{window.lastScore}%20points%20on%20PlaySnakeNow!'
  target='_blank'>
  Tweet Score</a>"
  # data-text='I have just scored #{window.lastScore} points on PlaySnakeNow!'

  $('#shareScore').html(scoreSpan + tweetBtn)
  $('#menuPanel').removeClass('hidden')
  $('#scorePanel').addClass('hidden')


# Update the snake speed
window.updateSpeed = (newSpeed) ->
  if (3 <= newSpeed <= 9)
    window.speed = newSpeed
  $('#speedVal').text(window.speed)

# Start the game
window.startGame = (ctx) ->
  window.player.score = 0
  updateScore()
  window.grid.moveApple(window.player.body)
  window.player.initialPosition()
  window.gameOver = false

  $('#menuPanel').addClass('hidden')
  $('#scorePanel').removeClass('hidden')
  gameLoop ctx

checkSnakeEatApple = ->
  snake = window.player.head()
  apple = window.grid.apple
  # increase score and update the text
  if ( snake[0] is apple[0] ) and (snake[1] is apple[1])
    window.player.eat()
    window.grid.moveApple(window.player.body)
    updateScore()

checkSnakeHitWalls = ->
  snake = window.player.head()
  if (snake[0] < 0) or (snake[0] >= window.grid.width) \
  or (snake[1] < 0) or (snake[1] >= window.grid.height)
    return true
  return false

gameLoop =  (ctx) ->
  if not  window.gameOver
    clear(ctx)
    grid.draw(ctx)
    player.draw(ctx)
    checkSnakeEatApple()
    window.gameOver = (checkSnakeHitWalls() or window.player.isEatingItself())
    setTimeout((-> gameLoop ctx), 1000/(window.speed * 2));
  else
    # Game finished, show the controls
    window.lastScore = window.player.score
    displayGameOver(ctx)
    showMenuPanel(ctx)

jQuery(document).ready ->
  # Setup the canvas
  c = document.getElementById('c')
  ctx = c.getContext('2d')
  window.grid = new Grid

  c.width = window.grid.pixelWidth()
  c.height = window.grid.pixelHeight()
  displaySplashScreen ctx



  # Player score
  window.lastScore = 0
  window.gameOver = true
  window.speed = 5
  window.player = new Player 20, window.speed

  $(document).keydown (e) =>
    if (e.keyCode is 39) # Right
      player.setDir 'right'
    else if (e.keyCode is 37) # Left
      player.setDir 'left'
    else if (e.keyCode is 40) # Down
      player.setDir 'down'
      e.preventDefault()
    else if (e.keyCode is 38) # Up
      player.setDir 'up'
      e.preventDefault()
    else if (e.keyCode is 83) # S
      startGame ctx



