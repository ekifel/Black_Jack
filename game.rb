require_relative 'user'
require_relative 'deck'

class Game
	attr_reader :user, :dealer, :deck, :card_index, :shuffle_deck, :bank

	BET = 10

	def initialize(user_name)
		@user = User.new(user_name)
		@dealer = User.new('Dealer')
		@deck = Deck.new
	end

	def new_round
		@shuffle_deck = deck.shuffle_deck
		@card_index = 0
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
  	@user.bank == 0 || @dealer.bank == 0
  end

  def add_card(player)
  	if can_add_card?(player)
  		player.cards << @shuffle_deck[@card_index]
  		player.score += @deck.card_value(@shuffle_deck[@card_index])
  		@card_index += 1
  	end
  end

  def dealer_step
  	add_card(@dealer) if @dealer.score < 17
  end

  def can_add_card?(player)
  	player.cards.size < 3
  end

  def round_result
  	winner = round_winner
  	if winner 
  		winner.take_a_win(@bank)
  	else
  		@user.take_a_win(@bank / 2)
  		@dealer.take_a_win(@bank / 2)
  	end
  end

  def round_winner
  	if @user.score > @dealer.score && @user.score <= 21
  		@user
  	elsif @dealer.score > @user.score && @dealer.score <= 21
  		@dealer
  	else 
  		false
  	end
  end
end



