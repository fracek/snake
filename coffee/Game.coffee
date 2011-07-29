# Setup the canvas
c = document.getElementById('c')
c.width = window.grid.pixelWidth()
c.height = window.grid.pixelHeight()

window.ctx = c.getContext('2d')


clear = ->
  ctx.fillStyle = "#8CC09F"
  ctx.beginPath()
  ctx.rect(0, 0, c.width, c.height)
  ctx.closePath()
  ctx.fill()


updateScore = ->
  $('#playerScore').text(window.score)

# Update the snake speed
window.updateSpeed = (newSpeed) ->
  if (3 <= newSpeed <= 9)
    window.speed = newSpeed
  $('#speedVal').text(window.speed)

# Start the game
window.startGame = ->
  window.score = 0
  updateScore()
  window.grid.moveApple()
  window.player.initialPosition()
  window.gameOver = false

  $('#menuPanel').addClass('hidden')
  $('#scorePanel').removeClass('hidden')
  console.log window.score
  gameLoop();

checkSnakeEatApple = ->
  snake = window.player.head()
  apple = window.grid.apple
  # increase score and update the text
  if ( snake[0] is apple[0] ) and (snake[1] is apple[1])
    window.player.eat()
    window.grid.moveApple()
    window.score += (10 * window.speed)
    updateScore()

checkSnakeHitWalls = ->
  snake = window.player.head()
  if (snake[0] < 0) or (snake[0] >= window.grid.width) \
  or (snake[1] < 0) or (snake[1] >= window.grid.height)
    return true
  return false

gameLoop =  ->
  if not  window.gameOver
    clear()
    grid.draw()
    player.draw()
    checkSnakeEatApple()
    window.gameOver = (checkSnakeHitWalls() or window.player.isEatingItself())
    setTimeout(gameLoop, 1000/(window.speed * 2));
  else
    # Game finished, show the controls
    $('#menuPanel').removeClass('hidden')
    $('#scorePanel').addClass('hidden')

# Player score
window.score = 0
window.gameOver = true
window.speed = 5


document.onkeydown = (e) ->
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
    startGame()
