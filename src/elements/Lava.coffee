mathjs = require 'mathjs'

class Lava extends PIXI.Graphics
  x: null
  y: null
  w: null
  h: null
  color: null
  isBad: true

  constructor: (x, y, w, h) ->
    super()
    @color = c
    @x = mathjs.randomInt(0, window.innerWidth)
    @y = 0
    @w = w
    @h = h
    build()

  build:=>
    @beginFill(0xff0000)
    @drawRect(@posX, @posY, @w, @h)
    @endFill()

  animate: =>
    return if @pause
    @x += 2
    @y += 2


module.exports = Lava