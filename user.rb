class User
	attr_accessor :cards, :score
	attr_reader :name, :bank

	def initialize(name)
		@name = name
		@bank = 100		
		@cards = []
		@score = 0
	end

	def make_a_bet(bet)
		@bank -= bet
	end

	def take_a_win(bank)
		@bank += bank
	end
end
