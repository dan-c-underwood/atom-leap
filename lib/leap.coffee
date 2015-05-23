{Emitter, CompositeDisposable} = require 'atom'
LeapAPI = require 'leapjs'

{jQuery} = require 'atom-space-pen-views'

module.exports =
  class Leap

    constructor: (args) ->
      @controller = new LeapAPI.Controller()
      @emitter = new Emitter
      @velocity = 0
      @step = 0.15
      @editor = null

    run: ->
      @controller.on 'deviceFrame', (frame) =>
        @editor = atom.workspace.getActiveTextEditor()
        if frame.gestures.length > 0
          for gesture in frame.gestures
            @processGesture(gesture)
            @processMovement()

          @animate(@editor.getScrollTop(), @editor.getScrollTop() + (@editor.getLineHeightInPixels() * @velocity))

      @controller.on 'deviceRemoved', =>
        @emitter.emit 'lm-removed'
        console.log "Leap Motion Removed"

      @controller.on 'streamingStarted', =>
        @emitter.emit 'lm-connected'

    start: ->
      @run()
      @controller.connect()
      console.log "Leap Motion Controller Connected"

    stop: ->
      @controller.disconnect()
      console.log "Leap Motion Controller Disconnected"

    connected: ->
      return @controller.connected()

    processGesture: (gesture) ->
      # Gesture handling
      atom.workspace.observeTextEditors (editor) ->
      switch gesture.type
        when "swipe"
          horizontal = Math.abs(gesture.direction[0]) > Math.abs(gesture.direction[1])
          if horizontal
            if gesture.direction[0] > 0
              # Right
              console.log "Right Swipe"
            else
              # Left
              console.log "Left Swipe"
          else
            if gesture.direction[1] > 0
              # Up
              console.log "Up Swipe"
              if @velocity < 0
                @velocity += (5 * @step)
              else
                @velocity += @step

            else
              # Down
              console.log "Down Swipe"
              if @velocity > 0
                @velocity -= (5 * @step)
              else
                @velocity -= @step

    processMovement: ->
      @editor.setScrollTop(@editor.getScrollTop() + (@editor.getLineHeightInPixels() * @velocity))
      if @velocity < 0.1 && @velocity > -0.1
        @velocity = 0

    animate: (start, end) ->
      velocity = @velocity

      velocity = (currentVelocity) =>
        0.75 * @editor.setScrollTop(currentVelocity)

      done = ->
        animationRunning = false
        @velocity = 0

      unless animationRunning
        animationRunning = true
        animationDuration = 100
        jQuery({top: start}).animate({top: end}, duration: animationDuration, easing: "swing", step: velocity, done: done)
