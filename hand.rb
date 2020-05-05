# frozen_string_literal: true

class Hand
  attr_accessor :cards
  attr_reader :score

  def initialize(cards)
    @cards = cards
    @score = 0
  end

  def count_the_score
    @score += cards.last.price
    recount
  end

  def recount
    a = %w[A<3 A^ A+ A<>]
    flag = false
    @cards.each do |card|
      flag = true if a.include?(card.name)
    end
    @score -= 10 if @score > 21 && flag
  end

  def show_cards(player)
    print "Карты #{player.name}: "
    @cards.each do |card|
      print "#{card.name} "
    end
    puts " Счет: #{@score}"
  end
end
