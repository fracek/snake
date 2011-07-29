size = 10 # Each piece of the body is 10px X 10px

class Player

  constructor: ->
    # Initial position
    @body = [[10, 10], [11, 10], [12, 10], [13, 10]]
    @dir = 'left'

  setDir: (d) ->

    if (d is 'left' and @dir is 'right') \
    or (d is 'right' and @dir is 'left') \
    or (d is 'up' and @dir is 'down') \
    or (d is 'down' and @dir is 'up')
        newDir = @dir
    else
      newDir = d

    @dir = newDir

  head: ->
    @body[@body.length - 1]

  move: ->
    currentHead = @head()
    x = currentHead[0]
    y = currentHead[1]

    switch @dir
      when 'left' then x--
      when 'right' then x++
      when 'up' then y--
      when 'down' then y++

    @body.push [x, y]

    # Remove the old tail
    @body = @body[1...@body.lenght]

  draw: ->
    @move()
    ctx.fillStyle = '#2F2F2F'
    @body.forEach (piece) ->
      ctx.fillRect(piece[0] * size, piece[1] * size, size, size)

window.player = new Player
