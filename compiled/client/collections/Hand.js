// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.Hand = (function(_super) {
    __extends(Hand, _super);

    function Hand() {
      return Hand.__super__.constructor.apply(this, arguments);
    }

    Hand.prototype.model = Card;

    Hand.prototype.initialize = function(array, deck, isDealer) {
      this.deck = deck;
      this.isDealer = isDealer;
    };

    Hand.prototype.hit = function() {
      this.add(this.deck.pop());
      if (this.busted()) {
        return this.trigger('bust');
      }
    };

    Hand.prototype.stand = function() {
      return this.trigger('stand');
    };

    Hand.prototype.scores = function() {
      var hasAce, score;
      hasAce = this.reduce(function(memo, card) {
        return memo || card.get('value') === 1;
      }, false);
      score = this.reduce(function(score, card) {
        return score + (card.get('revealed') ? card.get('value') : 0);
      }, 0);
      if (hasAce) {
        return [score, score + 10];
      } else {
        return [score];
      }
    };

    Hand.prototype.newDeal = function() {
      while (!this.isEmpty()) {
        this.deck.unshift(this.pop());
      }
      this.add([this.deck.pop(), this.deck.pop()]);
      if (this.isDealer && this.first().get('revealed')) {
        return this.first().flip();
      }
    };

    Hand.prototype.busted = function() {
      if (this.scores()[0] > 21) {
        return true;
      }
    };

    Hand.prototype.playToWin = function() {
      this.first().flip();
      while (this.maxScore() < 17) {
        this.hit();
      }
      if (!this.busted()) {
        return this.trigger('stand');
      }
    };

    Hand.prototype.maxScore = function() {
      if (this.scores()[1] && this.scores()[1] < 21) {
        return this.scores()[1];
      } else {
        return this.scores()[0];
      }
    };

    return Hand;

  })(Backbone.Collection);

}).call(this);

//# sourceMappingURL=Hand.map
