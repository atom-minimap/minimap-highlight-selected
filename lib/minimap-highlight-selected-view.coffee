_ = require 'underscore-plus'
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

      @removeMarkers()

      editor = @getActiveEditor()
      return unless editor
      return if editor.getLastSelection().isEmpty()
      return unless @isWordSelected(editor.getLastSelection())

      @selections = editor.getSelections()

      text = _.escapeRegExp(@selections[0].getText())
      regex = new RegExp("\\S*\\w*\\b", 'gi')
      result = regex.exec(text)

      return unless result?
      return if result[0].length < atom.config.get(
        'highlight-selected.minimumLength') or
                result.index isnt 0 or
                result[0] isnt result.input

      regexFlags = 'g'
      if atom.config.get('highlight-selected.ignoreCase')
        regexFlags = 'gi'

      range =  [[0, 0], editor.getEofBufferPosition()]

      @ranges = []
      regexSearch = result[0]
      if atom.config.get('highlight-selected.onlyHighlightWholeWords')
        regexSearch =  "\\b" + regexSearch + "\\b"

      editor.scanInBufferRange new RegExp(regexSearch, regexFlags), range,
        (result) =>
          marker = editor.markBufferRange(result.range)
          className = @makeClasses(@showHighlightOnSelectedWord(result.range, @selections))

          decoration = editor.decorateMarker(marker, {
            type: 'highlight'
            class: className
            plugin: 'highlight-selected'
          })
          @views.push marker

    makeClasses: (inSelection) ->
      className = 'highlight-selected'
      className += ' selected' if inSelection

      className

    subscribeToActiveTextEditor: ->
      @selectionSubscription?.dispose()
      @selectionSubscription = new CompositeDisposable

      if editor = @getActiveEditor()
        @selectionSubscription.add editor.onDidAddSelection =>
          @handleSelection()
        @selectionSubscription.add editor.onDidChangeSelectionRange =>
          @handleSelection()

      @handleSelection()
