# The Player, a.k.a. the snake
class Player

  constructor: (@size = 10) ->
    # Snake's body
    @body = []
    for i in [10...18]
      @body.push [i, 10]
    @dir = 'right'
    @isEating = false

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

    # Remove the old tail, but if it's eating grow by one piece
    @body = @body[1...@body.lenght] unless @isEating

  eat: -> @isEating = true
  stopEating: -> @isEating = false

  draw: ->
    @move()
    @stopEating()
    size = @size
    ctx.fillStyle = '#2F2F2F'
    @body.forEach (piece) ->
      ctx.fillRect(piece[0] * size, piece[1] * size, size, size)

# Create player
window.player = new Player 20
