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
    @players = [@human, @android]
    @iter_players = @players.cycle
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
    loop do
      begin
        @player = @iter_players.next
        show_cards
        case @player.run(@deck)
          when :pass
            puts "#{@player} пропускает"
          when :game_end
            show_winner
            break
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

  def show_winner
    show_cards(true)
    winner = @players.select{|x| !x.lost?}.max_by{|x| x.scores}
    if winner.nil?
      puts "Ничья"
    else
      puts "Выиграл #{winner}"
    end
  end

  def show_cards(visible=false)
    puts "#{@human}, #{@human.show_cards(true)}, score: #{@human.score}"
    puts "#{@android}, #{@android.show_cards(visible)}" + ", score: #{@android.score}" if visible
  end
end

if __FILE__==$0
  main = Main.new
  main.run
end