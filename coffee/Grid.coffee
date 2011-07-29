class Grid
  constructor: (@width = 30, @height = 2 / 3 * @width, @scale = 20) ->
    @apple = @newApple()

  pixelWidth: -> @width * @scale
  pixelHeight: -> @height * @scale

  newApple: ->
    x = ~~(Math.random() * @width)
    y = ~~(Math.random() * @height)
    [x, y]

  draw: ->
    ctx.fillStyle = 'red'
    ctx.fillRect(@apple[0] * @scale, @apple[1] * @scale, @scale, @scale)

window.grid = new Grid