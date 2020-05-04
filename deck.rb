class Deck
	CARD_VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].freeze
	CARD_SUITS = ['<3', '<>', '+', '^'].freeze

	attr_reader :cards

	def initialize
		@cards = {}
		CARD_VALUES.each do |value|
			CARD_SUITS.each do |suit|
				score = value if (2..10).include?(value)
				score = 10 if %w[J Q K].include?(value)
				score = 11 if value == 'A'
				@cards["#{value}#{suit}"] = score
			end
		end
	end

	def shuffle_deck
		@cards.keys.shuffle!
	end

	def card_value(value)
		@cards[value]
	end
end
