class User
	attr_accessor :cards, :bank
	attr_reader :name, :score

	def initialize(name)
		@name = name
		@bank = 100
		@cards = []
	end

	def make_a_bet
		@bank -= 10
	end

	def take_a_win
		@bank += 10
	end
end
