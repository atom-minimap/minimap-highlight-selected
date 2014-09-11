{Subscriber} = require 'emissary'

class MinimapHighlightSelected
  Subscriber.includeInto(this)

  activate: (state) ->
    @highlightSelectedPackage = atom.packages.getLoadedPackage('highlight-selected')
    @minimapPackage = atom.packages.getLoadedPackage('minimap')

    return @deactivate() unless @highlightSelectedPackage? and @minimapPackage?

    @MinimapHighlightSelectedView = require('./minimap-highlight-selected-view')()

    @minimap = require @minimapPackage.path
    @highlightSelected = require @highlightSelectedPackage.path

    @minimap.registerPlugin 'highlight-selected', this

  deactivate: ->
    @deactivatePlugin()
    @minimapPackage = null
    @highlightSelectedPackage = null
    @highlightSelected = null
    @minimap = null

  isActive: -> @active
  activatePlugin: ->
    return if @active
    return unless @minimap.active

    @active = true

    @createViews()

    @subscribe @minimap, 'activated', @createViews
    @subscribe @minimap, 'deactivated', @destroyViews

  deactivatePlugin: ->
    return unless @active

    @active = false
    @destroyViews()
    @unsubscribe()

  createViews: =>
    return if @viewsCreated

    @viewsCreated = true
    @view = new @MinimapHighlightSelectedView(@minimap)
    @view.handleSelection()

  destroyViews: =>
    return unless @viewsCreated
    @viewsCreated = false
    @view.removeMarkers()
    @view.destroy()

module.exports = new MinimapHighlightSelected
