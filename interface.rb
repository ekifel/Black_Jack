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
      show_dealer_stat
      user_stat
      @game.round_result
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

  def show_winner
    if @game.user.bank.zero?
      puts 'Game over. Вы банкрот'
    else puts 'Game over. Вы победили!'
    end
  end

  def show_dealer_stat
    puts "Карты дилера: #{@game.dealer.cards}, Счет: #{game.dealer.score}," \
    "Банк: #{@game.dealer.bank}}"
  end

  def user_stat
    puts "Ваши карты: #{@game.user.cards}, Счет: #{@game.user.score}," \
    "Банк: #{@game.user.bank}"
  end

  def user_step
    return unless @game.can_add_card?(@game.user)

    user_stat
    puts '1. Взять карту; 2. Открыться'
    user_answer = gets.chomp.to_i
    @game.add_card(@game.user) if user_answer == 1
    @game.user.recount
  end
end
