

c = document.getElementById('c')
c.width = 600
c.height = 450

window.ctx = c.getContext('2d')

clear = ->
  ctx.fillStyle = "#8CC09F"
  ctx.beginPath()
  ctx.rect(0, 0, 600, 450)
  ctx.closePath()
  ctx.fill()


gameLoop =  ->
  clear()
  player.draw()
  setTimeout(gameLoop, 1000/10);

gameLoop();

document.onkeydown = (e) ->

  if (e.keyCode is 39) # Right
    player.setDir 'right'
  else if (e.keyCode is 37) # Left
    player.setDir 'left'
  else if (e.keyCode is 40) # Down
    player.setDir 'down'
  else if (e.keyCode is 38) # Up
    player.setDir 'up'