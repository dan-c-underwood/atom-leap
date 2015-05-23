{Emitter, CompositeDisposable} = require 'atom'
State = {OFFLINE : 0, INACTIVE : 1, ACTIVE : 2}

class AtomLeapView extends HTMLElement
  initialize: ->
    @classList.add('leap', 'inline-block')

    div = document.createElement('div')
    div.classList.add('leap-container')

    @leapStatus = document.createElement('span')
    @leapStatus.classList.add('leap-status')
    @leapStatus.textContent = "LM:O"
    div.appendChild(@leapStatus)

    @appendChild(div)

  constructor: (serializedState) ->

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element

  @content: ->
    @div class: 'leap-status inline-block'

  setState: (state) ->
    switch state
      when State.OFFLINE
        @leapStatus.textContent = "LM:O"
      when State.INACTIVE
        @leapStatus.textContent = "LM:I"
      when State.ACTIVE
        @leapStatus.textContent = "LM:A"

module.exports = document.registerElement('status-bar-leap', prototype: AtomLeapView.prototype, extends: 'div')
