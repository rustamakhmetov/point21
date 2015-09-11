#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

require_relative 'human_player'
require_relative 'android_player'
require_relative 'user_exception'

class Main
  def initialize
    @android = AndroidPlayer("Дилер")
  end

  def run
    puts "Игра блэкджек. Введите свое имя:"
    name = gets.chomp
    @human = HumanPlayer.new(name)
    while true do
      begin
        show_menu
        menu_id = gets.to_i
        case menu_id
          when 1
            #add_station
          when 2
            #add_train
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
    #puts "Current station: #{@station}, train: #{@train}"
    puts """Выберите:
   1. Пропустить
   2. Добавить карту
   3. Открыть карты
   4. Выход
"""
  end
end

if __FILE__==$0
  main = Main.new
  main.run
end