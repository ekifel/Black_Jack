# frozen_string_literal: true

require_relative 'card'

class Deck
  attr_reader :cards

  def initialize
    @cards = []
    create_deck
  end

  def shuffle
    @cards.shuffle!
  end

  private

  def create_deck
    Card::CARD_VALUES.each do |value|
      Card::CARD_SUITS.each do |suit|
        price = value if (2..10).include?(value)
        price = 10 if %w[J Q K].include?(value)
        price = 11 if value == 'A'
        @cards << Card.new("#{value}#{suit}", price)
      end
    end
  end
end
