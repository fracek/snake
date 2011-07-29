class Grid
  constructor: (@width = 30, @height = 2 / 3 * @width, @scale = 20) ->
    @apple = @newApple()
    @img = new Image()
    @img.src = 'apple.png'

  pixelWidth: -> @width * @scale
  pixelHeight: -> @height * @scale

  newApple: ->
    x = ~~(Math.random() * @width)
    y = ~~(Math.random() * @height)
    [x, y]

  moveApple: -> @apple = @newApple()

  draw: ->
    try
      ctx.drawImage(@img, @apple[0] * @scale, @apple[1] * @scale, @scale, @scale)
    catch e
      # do nothing

window.grid = new Grid