{CompositeDisposable} = require 'event-kit'
{requirePackages} = require 'atom-utils'

class MinimapHighlightSelected
  constructor: ->
    @subscriptions = new CompositeDisposable

  activate: (state) ->

  consumeMinimapServiceV1: (@minimap) ->
    @minimap.registerPlugin 'highlight-selected', this

  consumeHighlightSelectedServiceV1: (@highlightSelected) ->
    @init() if @minimap? and @active?

  deactivate: ->
    @deactivatePlugin()
    @minimapPackage = null
    @highlightSelectedPackage = null
    @highlightSelected = null
    @minimap = null

  isActive: -> @active

  activatePlugin: ->
    return if @active

    @subscriptions.add @minimap.onDidActivate @init
    @subscriptions.add @minimap.onDidDeactivate @dispose

    @active = true
    @init() if @highlightSelected?

  init: ->
    @decorations = []
    @highlightSelected.onDidAddMarker (marker) => @markerCreated(marker)

  dispose: ->
    @decorations.forEach (decoration) -> decoration.destroy()
    @decorations = null

  markerCreated: (marker) =>
    activeMinimap = @minimap.getActiveMinimap()
    return unless activeMinimap?

    decoration = activeMinimap.decorateMarker(marker,
      {type: 'highlight', class: @highlightSelected.makeClasses()})
    @decorations.push decoration

  deactivatePlugin: ->
    return unless @active

    @active = false
    @dispose()
    @subscriptions.dispose()

module.exports = new MinimapHighlightSelected
