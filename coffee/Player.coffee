# The Player, a.k.a. the snake
class Player

  constructor: (@size = 10, @speed) ->
    @score = 0
    # Snake's body
    @initialPosition()

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

  initialPosition: ->
    @body = []
    for i in [10...18]
      @body.push [i, 10]
    @dir = 'right'
    @isEating = false

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

  isEatingItself: ->
    # If the @body has duplicates then the snake is eating itself
    head = @head()
    go = false
    bodyWithoutHead = @body[0...@body.length-1]
    bodyWithoutHead.forEach (piece) ->

      x = piece[0]
      y = piece[1]
      if ((head[0] is x) and (head[1] is y))
        go = true

    return go

  eat: ->
    @isEating = true
    @score += 10 * @speed

  stopEating: -> @isEating = false

  draw: (ctx) ->
    @move()
    @stopEating()
    size = @size
    ctx.fillStyle = '#2F2F2F'
    ctx.strokeStyle = '#C7FAD9'
    @body.forEach (piece) ->
      ctx.beginPath()
      ctx.rect(piece[0] * size, piece[1] * size, size, size)
      ctx.closePath()
      ctx.fill()
      ctx.stroke()

window.Player = Player