class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button><button class="reload-button">Reload</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()
    "click .reload-button": ->
      @model.reload()
      @render()

  initialize: ->
    @render()
    @model.on "all", @eventHandler, @


  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  eventHandler: (event)->
    switch event
      when "playerWins" then alert("Player wins!")
      when "dealerWins" then alert("Dealer wins!")
      when "tie" then alert("its a tie!")
    $('.hit-button').attr 'disabled', true
    $('.stand-button').attr 'disabled', true



