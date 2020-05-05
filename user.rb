# frozen_string_literal: true

require_relative 'hand'

class User
  attr_accessor :hand
  attr_reader :name, :bank

  def initialize(name)
    @name = name
    @bank = 100
    @hand = Hand.new([])
  end

  def make_a_bet(bet)
    @bank -= bet
  end

  def take_a_win(bank)
    @bank += bank
  end

  def refresh
    @hand = Hand.new([])
  end
end
