{View} = require 'atom'

module.exports = () ->
  highlightSelectedPackage = atom.packages.getLoadedPackage('highlight-selected')
  
  highlightSelected = require (highlightSelectedPackage.path)
  HighlightedAreaView = require (highlightSelectedPackage.path + '/lib/highlighted-area-view')

  class MinimapHighlightSelectedView extends HighlightedAreaView
    constructor: (@minimap) ->
      super

    getActiveEditor: -> @minimap.getActiveMinimap()
