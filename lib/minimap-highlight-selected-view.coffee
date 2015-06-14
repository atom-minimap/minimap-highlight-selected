module.exports = ->
  class MinimapHighlightSelectedView
    constructor: (minimap, highlightSelectedService) ->
      @decorations              = []
      @minimap                  = minimap
      @highlightSelectedService = highlightSelectedService

      @highlightSelectedService.onDidAddMarker (marker) =>
        @markerCreated(marker)

    markerCreated: (marker) =>
      activeMinimap = @minimap.getActiveMinimap()
      return unless activeMinimap

      decoration = activeMinimap.decorateMarker(marker,
        {type: 'highlight', class: @highlightSelectedService.makeClasses()})
      @decorations.push decoration

    removeMarkers: =>
      @decorations.forEach (decoration) -> decoration.destroy()
