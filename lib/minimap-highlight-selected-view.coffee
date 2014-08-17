_ = require 'underscore-plus'
{View} = require 'atom'
MarkerView = require './marker-view'

module.exports = ->
  highlightSelectedPackage = atom.packages.getLoadedPackage('highlight-selected')
  minimapPackage = atom.packages.getLoadedPackage('minimap')

  minimap = require (minimapPackage.path)
  highlightSelected = require (highlightSelectedPackage.path)
  HighlightedAreaView = require (highlightSelectedPackage.path + '/lib/highlighted-area-view')

  class MinimapHighlightSelectedView extends HighlightedAreaView
    constructor: (@editorView) ->
      super
      @paneView = @editorView.editorView.getPane()
      @subscribe @paneView.model.$activeItem, @onActiveItemChanged

    attach: ->
      @subscribe @editorView.editorView, "selection:changed", @handleSelection

      if @editorView?
        @editorView.miniOverlayer.append(this)
        @css fontSize: @editorView.getLineHeight() + 'px'
        # @adjustResults()

    detach: ->
      super
      @unsubscribe @editorView.editorView, "selection:changed", @handleSelection

    destroy: ->
      @detach()
      super

    adjustResults: ->
      @css '-webkit-transform', "scale3d(#{minimap.getCharWidthRatio()},1,1)"

    onActiveItemChanged: (item) =>
      return if item is @activeItem

      if @paneView.activeView is @editorView.editorView
        @attach()
      else
        @detach()

    handleSelection: =>
      @removeMarkers()

      return unless editor = @getActiveEditor()
      return if editor.getSelection().isEmpty()
      return unless @isWordSelected(editor.getSelection())

      @selections = editor.getSelections()

      text = _.escapeRegExp(@selections[0].getText())
      regex = new RegExp("\\W*\\w*\\b", 'gi')
      result = regex.exec(text)

      return unless result?
      return if result.length is 0 or
                result.index isnt 0 or
                result[0] isnt result.input

      range =  [[0, 0], editor.getEofBufferPosition()]

      @ranges = []
      regexSearch = result[0]
      if atom.config.get('highlight-selected.onlyHighlightWholeWords')
        regexSearch =  "\\b" + regexSearch + "\\b"
      editor.scanInBufferRange new RegExp(regexSearch, 'g'), range,
        (result) =>
          if prefix = result.match[1]
            result.range = result.range.translate([0, prefix.length], [0, 0])
          @ranges.push editor.markBufferRange(result.range).getScreenRange()

      for range in @ranges
        unless @showHighlightOnSelectedWord(range, @selections)
          view = new MarkerView(range, this, @editorView)
          @append view.element
          @views.push view

    removeMarkers: =>
      return unless @views?
      return if @views.length is 0

      for view in @views
        view.destroy()
        view = null
      @views = []
