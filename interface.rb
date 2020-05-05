# frozen_string_literal: true

require_relative 'game'

class Interface
  attr_reader :game, :end_round

  def start
    puts 'Введите имя'
    user_name = gets.chomp
    @game = Game.new(user_name)
    action
  end

  def action
    loop do
      @game.new_round
      user_step
      @game.dealer_step
      show_round_result
      show_dealer_stat
      user_stat
      unless @game.can_continue?
        show_winner
        break
      end
      puts 'Продолжить? 1. Да, 2. Нет'
      user_input = gets.chomp.to_i
      next if user_input == 1
      break if user_input == 2
    end
  end

  def show_round_result
    puts '********************************'
    @game.round_result
    puts '********************************'
  end

  def show_winner
    if @game.user.bank.zero?
      puts 'Game over. Вы банкрот'
    else puts 'Game over. Вы победили!'
    end
  end

  def show_dealer_stat
    @game.dealer.hand.show_cards(@game.dealer)
    puts "Банк дилера: #{@game.dealer.bank}"
  end

  def user_stat
    @game.user.hand.show_cards(@game.user)
    puts "Ваш банк: #{@game.user.bank}"
  end

  def user_step
    return unless @game.can_add_card?(@game.user)

    user_stat
    puts '1. Взять карту; 2. Открыться'
    user_answer = gets.chomp.to_i
    @game.add_card(@game.user) if user_answer == 1
  end
end
