fdata = require('./assets/Jugador.json')
Jugador = require('./assets/Jugador.png')
BgImage = require('./assets/bg.png')
stage = require('./elements/stage')
Roca = require('./elements/Roca')
audio = require './assets/C.wav'
sound = require 'Howler'
mathjs = require 'mathjs'

class App extends PIXI.Application
  animation:true
  animationNodes:[]
  myStage: stage
  enemies: []
  constructor:(w,h,o)->
    super(w,h,o)
    window.addEventListener 'keydown', @onKeyPress
    window.addEventListener 'keyup', @onKeyUp
    document.body.appendChild @view
    @preload()
    @buildEnemy2()
    @animate()

  play:->
    console.log 'howl'
    sound = new sound.Howl(
      {
        src: ['images/C.wav']
        loop:true
        autoplay:true
      }
    )
    sound.play()
    null

  onKeyPress: (evt) =>
    if evt.key is 'a'
      return if @anim.x  < 15
      @anim.x -= 12
      @frame.splice(0,25)
      for i in [9..10]
        @frame.push(PIXI.Texture.fromFrame("#{i}.png"))

    if evt.key is 'd'
      return if @anim.x  > 585
      @anim.x += 12
      @frame.splice(0,25)
      for i in [13..14]
        @frame.push(PIXI.Texture.fromFrame("#{i}.png"))
        
  onKeyUp: (evt) =>
    if evt.key is 'a'
      @frame.splice(0,25)
      for i in [5..7]
        @frame.push(PIXI.Texture.fromFrame("#{11}.png"))

    if evt.key is 'd'
      @frame.splice(0,25)
      for i in [5..7]
        @frame.push(PIXI.Texture.fromFrame("#{14}.png"))
        
  preload:=>
      PIXI.loader.add(fdata).add(BgImage).load(@build)
    
  build:()=>
    Bg = new stage (BgImage)
    @stage.addChild Bg
    @play()
    
    @frame = []
    for i in [1...15] by 1
      node = PIXI.Texture.fromFrame("#{i}.png")
      @frame.push(node)
    @anim = new PIXI.extras.AnimatedSprite(@frame)

    @anim.x = 300
    @anim.y = 870
    @anim.anchor.set(0.5)
    @anim.scale.set(0.11)
    @anim.animationSpeed = 0.2
    @anim.play()
    @stage.addChild(@anim)

  buildEnemy2: =>
    setInterval =>
      @enemy = new Roca(10, 10, '0x4b3621')
      @stage.addChild(@enemy)
      @enemies.push(@enemy)
      @addAnimationNodes(@enemy)
    , 300

  addAnimationNodes:(node)=>
    @animationNodes.push node

  collisionBounds: (anim) =>
    if @anim.x > @view.width
      @anim.x = 0
    if @anim.x < 0
      @anim.x = @view.width

  animate:=>
    @ticker.add ()=>
      for n in @animationNodes
        n.animate?()

module.exports = App
