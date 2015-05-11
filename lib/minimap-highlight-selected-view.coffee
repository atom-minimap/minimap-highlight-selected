{Disposable, CompositeDisposable} = require 'atom'

module.exports = ->
  highlightSelectedPackage = atom.packages.getLoadedPackage('highlight-selected')

  highlightSelected = require (highlightSelectedPackage.path)
  HighlightedAreaView = require (highlightSelectedPackage.path + '/lib/highlighted-area-view')

  class FakeEditor
    constructor: (@minimap) ->

    getActiveMinimap: -> @minimap.getActiveMinimap()

    getActiveTextEditor: -> @getActiveMinimap()?.getTextEditor()

    ['markBufferRange', 'scanInBufferRange', 'getEofBufferPosition', 'getSelections', 'getLastSelection', 'bufferRangeForBufferRow', 'getTextInBufferRange'].forEach (key) ->
      FakeEditor::[key] = -> @getActiveTextEditor()?[key](arguments...)

    ['onDidAddSelection', 'onDidChangeSelectionRange'].forEach (key) ->
      FakeEditor::[key] = ->
        @getActiveTextEditor()?[key](arguments...) ? new Disposable ->

    ['decorateMarker'].forEach (key) ->
      FakeEditor::[key] = -> @getActiveMinimap()[key](arguments...)

  class MinimapHighlightSelectedView extends HighlightedAreaView
    constructor: (minimap) ->
      @fakeEditor = new FakeEditor(minimap)
      super

    getActiveEditor: -> @fakeEditor

    handleSelection: ->
      return unless atom.workspace.getActiveTextEditor()?
      return unless @fakeEditor.getActiveTextEditor()?
      super

    subscribeToActiveTextEditor: ->
      @selectionSubscription?.dispose()
      @selectionSubscription = new CompositeDisposable

      if editor = @getActiveEditor()
        @selectionSubscription.add editor.onDidAddSelection =>
          @handleSelection()
        @selectionSubscription.add editor.onDidChangeSelectionRange =>
          @handleSelection()

      @handleSelection()
