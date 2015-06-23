{CompositeDisposable} = require 'event-kit'
{requirePackages} = require 'atom-utils'
MinimapHighlightSelectedView = null

class MinimapHighlightSelected
  constructor: ->
    @subscriptions = new CompositeDisposable

  activate: (state) ->

  consumeMinimapServiceV1: (@minimap) ->
    requirePackages('highlight-selected').then ([@highlightSelected]) =>
      MinimapHighlightSelectedView = require('./minimap-highlight-selected-view')()

      @minimap.registerPlugin 'highlight-selected', this

  consumeHighlightSelectedServiceV1: (something) ->
    requirePackages('highlight-selected').then ([@highlightSelected]) =>
      @highlightSelectedService = @highlightSelected.provideHighlightSelectedV1()

  deactivate: ->
    @deactivatePlugin()
    @minimapPackage = null
    @highlightSelectedPackage = null
    @highlightSelected = null
    @minimap = null

  isActive: -> @active

  activatePlugin: ->
    return if @active

    @active = true

    @createViews()

    @subscriptions.add @minimap.onDidActivate @createViews
    @subscriptions.add @minimap.onDidDeactivate @destroyViews

  deactivatePlugin: ->
    return unless @active

    @active = false
    @destroyViews()
    @subscriptions.dispose()

  createViews: =>
    return if @viewsCreated

    @viewsCreated = true
    @view = new MinimapHighlightSelectedView(@minimap, @highlightSelectedService)

  destroyViews: =>
    return unless @viewsCreated
    @viewsCreated = false
    @view.removeMarkers()

module.exports = new MinimapHighlightSelected
