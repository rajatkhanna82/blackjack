#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'all',  @playerEvents, @
    @get('dealerHand').on 'all',  @dealerEvents, @

  reload: ->
    if @get('playerHand').get 'roundOver'
      @get('playerHand').set 'roundOver',false
    # @get('playerHand').newDeal()
    # @get('dealerHand').newDeal()
    # @set 'playerHand', @get('deck').dealPlayer()
    # @set 'dealerHand', @get('deck').dealDealer()

  playerEvents: (event) ->
    console.log("player event: #{event} ")
    switch event
      when 'bust' then @trigger 'dealerWins'
      when 'stand' then @get('dealerHand').playToWin()

  dealerEvents: (event) ->
    switch event
      when 'bust' then @trigger 'playerWins'
      when 'stand' then @checkScores()

  checkScores: ->
    @trigger 'playerWins' if @get('playerHand').maxScore() > @get('dealerHand').maxScore()
    @trigger 'dealerWins' if @get('playerHand').maxScore() < @get('dealerHand').maxScore()
    @trigger 'tie' if @get('playerHand').maxScore() == @get('dealerHand').maxScore()


