#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

require_relative 'human_player'
require_relative 'android_player'
require_relative 'user_exception'
require_relative 'deck'
require_relative 'bank'
require_relative 'utils'

class Main
  def initialize
    @android = AndroidPlayer.new("Дилер", 100)
    @human = HumanPlayer.new("Unknow", 100)
    @players = [@human, @android]
    @iter_players = @players.cycle
    @deck = Deck.new
    @bank = Bank.new
    @rate = 10
  end

  def run
    next_play?
    exit
    puts "Игра блэкджек. Введите свое имя:"
    name = "Rustam" #gets.chomp
    @human.name = name
    2.times do
      @human << @deck.shift
      @android << @deck.shift
    end
    #@human.bank.transfer(@bank, @rate)
    #@android.bank.transfer(@bank, @rate)
    @bank << @human.withdraw_money(@rate)
    @bank << @android.withdraw_money(@rate)
    loop do
      begin
        @player = @iter_players.next
        show_cards
        case @player.run(@deck)
          when :pass then puts "#{@player} пропускает"
          when :game_end
            show_winner
            if next_play?

            else
              break
            end
          when :game_break
            puts "Игра прервана"
            break
        end
      #rescue UserException => e
      #  puts e.message
      end
      sleep 1
    end
  end

  def next_play?
    menu = {
        1=> "Сыграть еще раз",
        2=> "Выйти"
    }
    menu_id = Utils.show_menu_with_select(menu)
    puts menu_id
  end

  def show_winner
    show_cards(true)
    winner = @players.select{|x| !x.lost?}.max_by{|x| x.scores}
    if winner.nil?
      puts "Ничья"
    else
      @bank.transfer(winner, @rate*2)
      puts "Выиграл #{winner}"
    end
  end

  def show_cards(visible=false)
    puts "#{@human}, #{@human.show_cards(true)}, score: #{@human.score}"
    puts "#{@android}, #{@android.show_cards(visible)}" + (", score: #{@android.score}" if visible)
  end
end

if __FILE__==$0
  main = Main.new
  main.run
end