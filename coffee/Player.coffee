
class Player

  constructor: ->
    # Initial position
    @x = 100
    @y = 100
    @size = 10
    @dir = 'left'

  setDir: (d) ->
    @dir = d

  move: ->
    switch @dir
      when 'left' then @x -= @size
      when 'right' then @x += @size
      when 'up' then @y -= @size
      when 'down' then @y += @size

  draw: ->
    @move()
    ctx.fillStyle = '#2F2F2F'
    ctx.fillRect(@x, @y, @size, @size)

window.player = new Player
