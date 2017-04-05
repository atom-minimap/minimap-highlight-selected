{CompositeDisposable} = require 'event-kit'
{requirePackages} = require 'atom-utils'

class MinimapHighlightSelected
  constructor: ->
    @subscriptions = new CompositeDisposable

  activate: (state) ->
    unless atom.inSpecMode()
      require('atom-package-deps').install 'minimap-highlight-selected', true

  consumeMinimapServiceV1: (@minimap) ->
    @minimap.registerPlugin 'highlight-selected', this

  consumeHighlightSelectedServiceV2: (@highlightSelected) ->
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

  init: =>
    @decorations = []
    @highlightSelected.onDidAddMarkerForEditor (options) => @markerCreated(options)
    @highlightSelected.onDidAddSelectedMarkerForEditor (options) => @markerCreated(options, true)
    @highlightSelected.onDidRemoveAllMarkers => @markersDestroyed()

  dispose: =>
    @decorations?.forEach (decoration) -> decoration.destroy()
    @decorations = null

  markerCreated: (options, selected = false) =>
    minimap = @minimap.minimapForEditor(options.editor)
    return unless minimap?
    className  = 'highlight-selected'
    className += ' selected' if selected

    decoration = minimap.decorateMarker(options.marker,
      {type: 'highlight', class: className })
    @decorations.push decoration

  markersDestroyed: =>
    @decorations?.forEach (decoration) -> decoration.destroy()
    @decorations = []

  deactivatePlugin: ->
    return unless @active

    @active = false
    @dispose()
    @subscriptions.dispose()

module.exports = new MinimapHighlightSelected
