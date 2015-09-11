#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

require_relative 'human_player'
require_relative 'android_player'
require_relative 'user_exception'
require_relative 'deck'

class Main
  def initialize
    @android = AndroidPlayer.new("Дилер", 100)
    @human = HumanPlayer.new("Unknow", 100)
    @iter_players = [@human, @android].cycle
    @deck = Deck.new
  end

  def run
    puts "Игра блэкджек. Введите свое имя:"
    name = "Rustam" #gets.chomp
    @human.name = name
    2.times do
      @human << @deck.shift
      @android << @deck.shift
    end
    while true do
      begin
        @player = @iter_players.next
        show_menu
        show_cards
        menu_id = gets.to_i
        case menu_id
          when 1
            puts "#{@player} pass"
          when 2
            @player << @deck.shift
          when 3
            #modify_train(menu_id)
          when 4
            puts "Игра прервана"
            break
          else
            puts "Неверный выбор"
        end
      rescue UserException => e
        puts e.message
      end
      sleep 1
    end
  end

  def show_menu
    system("clear")
    puts """Выберите:
   1. Пропустить
   2. Добавить карту
   3. Открыть карты
   4. Выход
"""
  end

  def show_cards
    puts "#{@human}, #{@human.show_cards(true)}, score: #{@human.score}"
    puts "#{@android}, #{@android.show_cards(false)}" #, score: #{@android.score}
  end
end

if __FILE__==$0
  main = Main.new
  main.run
end