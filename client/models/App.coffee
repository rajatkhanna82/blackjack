#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'hit', => @checkHitScore()
    @get('dealerHand').on 'checkScores', => @checkScores()

  checkHitScore: ->
    playerScore = if not@get('playerHand').scores()[1] or @get('playerHand').scores()[1] > 21
      @get('playerHand').scores()[0]
    else
      @get('playerHand').scores()[1]

    dealerScore = @get('dealerHand').scores()

    if playerScore > 21
     alert ("you Lose with #{playerScore}. The dealer has #{dealerScore}")

  checkScores: ->
    playerScore = if not@get('playerHand').scores()[1] or @get('playerHand').scores()[1] > 21
      @get('playerHand').scores()[0]
    else
      @get('playerHand').scores()[1]

    dealerScore = @get('dealerHand').scores()

    if playerScore > dealerScore
      alert "you win with #{playerScore}. The dealer has #{dealerScore}"
    else alert "you lose"

