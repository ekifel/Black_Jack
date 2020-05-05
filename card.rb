# frozen_string_literal: true

class Card
  CARD_VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].freeze
  CARD_SUITS = ['<3', '<>', '+', '^'].freeze

  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

  def self.create_deck
    deck = []
    CARD_VALUES.each do |value|
      CARD_SUITS.each do |suit|
        price = value if (2..10).include?(value)
        price = 10 if %w[J Q K].include?(value)
        price = 11 if value == 'A'
        deck << Card.new("#{value}#{suit}", price)
      end
    end
    deck
  end
end
