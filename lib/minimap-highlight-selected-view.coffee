{View} = require 'atom'

module.exports = ->
  highlightSelectedPackage = atom.packages.getLoadedPackage('highlight-selected')
  minimapPackage = atom.packages.getLoadedPackage('minimap')

  minimap = require (minimapPackage.path)
  highlightSelected = require (highlightSelectedPackage.path)
  HighlightedAreaView = require (highlightSelectedPackage.path + '/lib/highlighted-area-view')

  class MinimapHighlightSelectedView extends HighlightedAreaView
    constructor: ->
      super
      @paneView = @editorView.getPane()
      @subscribe @paneView.model.$activeItem, @onActiveItemChanged

    attach: ->
      @subscribe @editorView, "selection:changed", @handleSelection

      minimapView = @getMinimap()

      if minimapView?
        minimapView.miniOverlayer.append(this)
        @adjustResults()

    detach: ->
      super
      @unsubscribe @editorView, "selection:changed", @handleSelection

    adjustResults: ->
      @css '-webkit-transform', "scale3d(#{minimap.getCharWidthRatio()},1,1)"

    onActiveItemChanged: (item) =>
      return if item is @activeItem

      if @paneView.activeView is @editorView
        @attach()
      else
        @detach()

    getMinimap: ->
      if @editorView.hasClass('editor')
        return minimap.minimapForEditorView(@editorView)
