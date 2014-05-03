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
    playerScore = if @get('playerHand').scores()[1]
      @checkAScore('playerHand')
    else
      @get('playerHand').scores()[0]

    dealerScore =  if @get('dealerHand').scores()[1]
      @checkAScore('dealerHand')
    else
      @get('dealerHand').scores()[0]

    if dealerScore < 17
      @get('dealerHand').hit()
    else
      if playerScore > dealerScore or dealerScore > 21
        alert "you win with #{playerScore}. The dealer has #{dealerScore}"
      else if dealerScore is playerScore
        alert "its a tie"
      else
        alert "you lose with #{playerScore}. The dealer has #{dealerScore}"

    console.log("after Alert")

  checkAScore: (hand) ->
    score = if @get(hand).scores()[1] > 21
      @get(hand).scores()[0]
    else
      @get(hand).scores()[1]
    score
