# frozen_string_literal: true

class Card
  CARD_VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].freeze
  CARD_SUITS = ['<3', '<>', '+', '^'].freeze

  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end
