# frozen_string_literal: true

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

  def refresh
    @cards = []
    @score = 0
  end

  def recount
    a = %w[A<3 A^ A+ A<>]
    @score -= 10 if @score > 21 && (@cards & a).any?
  end
end
