# frozen_string_literal: true

require_relative 'card'

class Deck
  attr_reader :cards

  def initialize
    @cards = Card.create_deck
  end

  def shuffle
    @cards.shuffle!
  end
end
