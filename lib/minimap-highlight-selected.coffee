{Subscriber} = require 'emissary'

class MinimapHighlightSelected
  Subscriber.includeInto(this)

  views: {}

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

    @active = true

    @createViews() if @minimap.active

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
    @viewsSubscription = @minimap.eachMinimapView ({view}) =>
      highlightView = new @MinimapHighlightSelectedView(view)
      highlightView.attach()
      highlightView.handleSelection()
      @views[view.editor.id] = highlightView

  destroyViews: =>
    return unless @viewsCreated

    @viewsSubscription.off()
    @viewsCreated = false
    view.destroy() for id,view of @views
    @views = {}

module.exports = new MinimapHighlightSelected
