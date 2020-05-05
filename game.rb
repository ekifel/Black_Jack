# frozen_string_literal: true

require_relative 'user'
require_relative 'deck'

class Game
  attr_reader :user, :dealer, :deck, :card_index, :bank

  BET = 10

  def initialize(user_name)
    @user = User.new(user_name)
    @dealer = User.new('Dealer')
    @deck = Deck.new
  end

  def new_round
    @deck.shuffle
    @card_index = 0
    @user.refresh
    @dealer.refresh
    @user.make_a_bet(BET)
    @dealer.make_a_bet(BET)
    @bank = 2 * BET
    distribution
  end

  def distribution
    (0..3).each do |index|
      if index.odd?
        add_card(@dealer)
      else
        add_card(@user)
      end
    end
  end

  def can_continue?
    @user.bank != 0 && @dealer.bank != 0
  end

  def add_card(player)
    return unless can_add_card?(player)

    player.hand.cards << @deck.cards[@card_index]
    player.hand.count_the_score
    @card_index += 1
  end

  def dealer_step
    return unless @dealer.hand.score < 17

    add_card(@dealer)
  end

  def can_add_card?(player)
    player.hand.cards.size < 3 && player.hand.score <= 20
  end

  def round_result
    winner = round_winner
    if winner
      winner.take_a_win(@bank)
      puts "#{winner.name} выиграл раунд!"
    else
      puts 'В раунде ничья!'
      @user.take_a_win(@bank / 2)
      @dealer.take_a_win(@bank / 2)
    end
  end

  def round_winner
    if ((@user.hand.score > @dealer.hand.score) && @user.hand.score <= 21) ||
       (@dealer.hand.score > 21 && @user.hand.score <= 21)
      @user
    elsif ((@dealer.hand.score > @user.hand.score) && @dealer.hand.score <= 21) ||
          (@dealer.hand.score <= 21 && @user.hand.score > 21)
      @dealer
    else
      false
    end
  end
end
