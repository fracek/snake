class Grid
  constructor: (@width = 30, @height = 2 / 3 * @width, @scale = 20) ->
    @apple = @newApple()
    @img = new Image()
    @img.src = '/img/apple.png'

  pixelWidth: -> @width * @scale
  pixelHeight: -> @height * @scale

  newApple: ->
    x = ~~(Math.random() * @width)
    y = ~~(Math.random() * @height)
    [x, y]

  # Spawn a new apple, if it spawn under the snake respawn it
  moveApple: (snakeBody) ->
    @apple = @newApple()

    isUnderTheSnake = false

    snakeBody.forEach (piece) =>
      if (piece[0] is @apple[0]) and (piece[1] is @apple[1])
        isUnderTheSnake = true

    # Retry?
    if isUnderTheSnake
      return @moveApple snakeBody
    else
      return @apple

  draw: ->
    try
      ctx.drawImage(@img, @apple[0] * @scale, @apple[1] * @scale, @scale, @scale)
    catch e
      # do nothing

window.grid = new Grid