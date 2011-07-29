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

# Update the snake speed
window.updateSpeed = (newSpeed) ->
  if (1 <= newSpeed <= 7)
    window.speed = newSpeed

  console.log 'new speed: ' + window.speed

# Start the game
window.startGame = ->
  score = 0
  window.gameOver = false
  gameLoop();

checkSnakeEatApple = ->
  snake = window.player.head()
  apple = window.grid.apple
  # increase score and update the text
  if ( snake[0] is apple[0] ) and (snake[1] is apple[1])
    window.player.eat()
    window.grid.moveApple()
    score += (10 * window.speed)
    $('#playerScore').text(score)

checkSnakeHitWalls = ->
  snake = window.player.head()
  if (snake[0] < 0) or (snake[0] >= window.grid.width) \
  or (snake[1] < 0) or (snake[1] >= window.grid.height)
    return true
  return false

gameLoop =  ->
  console.log gameOver
  unless window.gameOver
    clear()
    grid.draw()
    player.draw()
    checkSnakeEatApple()
    window.gameOver = (checkSnakeHitWalls() or window.player.isEatingItself())
    setTimeout(gameLoop, 1000/((window.speed + 2) * 2));


# Player score
score = 0
window.gameOver = true
window.speed = 3


document.onkeydown = (e) ->
  console.log e.keyCode
  if (e.keyCode is 39) # Right
    player.setDir 'right'
  else if (e.keyCode is 37) # Left
    player.setDir 'left'
  else if (e.keyCode is 40) # Down
    player.setDir 'down'
  else if (e.keyCode is 38) # Up
    player.setDir 'up'
  else if (e.keyCode is 83) # S
    startGame()