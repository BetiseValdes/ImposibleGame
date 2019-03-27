mathjs = require 'mathjs'

class Roca extends PIXI.Graphics



  constructor: (w, h, color) ->
    super()
    @x = mathjs.randomInt(0, window.innerWidth)
    @y = 0
    @w = w
    @h = h
    @build()

  build:=>
    @beginFill(@color)
    @drawRect(@x, @y, @w, @h)
    @endFill()

  collision:() ->

  animate: =>
    return if @pause
    @x += 2
    @y += 2


module.exports = Roca