AtomLeapView = require './atom-leap-view'
Leap = require './leap'
{CompositeDisposable} = require 'atom'

State = {OFFLINE : 0, INACTIVE : 1, ACTIVE : 2}

module.exports = AtomLeap =
  atomLeapView: null
  subscriptions: null

  consumeStatusBar: (statusBar) ->
    @statusBarTile = statusBar.addRightTile(item: @atomLeapView, priority: 100)

  activate: (state) ->
    @active = false
    @leap = new Leap()

    @subscriptions = new CompositeDisposable

    @atomLeapView = new AtomLeapView()
    @atomLeapView.initialize()

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-leap:toggle': => @toggle()

    @leap.emitter.on 'lm-removed', =>
      @lmRemoved()

    @leap.emitter.on 'lm-connected', =>
      @lmConnected()

  deactivate: ->
    @statusBarTile?.destroy()
    @statusBarTile = null
    @subscriptions.dispose()
    @atomLeapView.destroy()

  serialize: ->

  toggle: ->
    @active = !@active
    if @active
      @leap.start()
      @paused = false
    else
      @leap.stop()
      @paused = true
    @atomLeapView.setState(@getLeapStatus())

  getLeapStatus: ->
    if @leap.connected() && @active
      return State.ACTIVE
    else if @paused
      return State.INACTIVE
    else
      return State.OFFLINE

  lmRemoved: ->
    @active = false
    @atomLeapView.setState(@getLeapStatus())

  lmConnected: ->
    @atomLeapView.setState(@getLeapStatus())
