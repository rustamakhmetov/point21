#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

require_relative 'human_player'
require_relative 'android_player'
require_relative 'deck'
require_relative 'bank'
require_relative 'utils'

class Main
  START_BANK = 100
  def initialize
    @android = AndroidPlayer.new("Дилер", START_BANK)
    @human = HumanPlayer.new("Unknow", START_BANK)
    @players = [@human, @android]
    @deck = Deck.new
    @bank = Bank.new
    @rate = 10
  end

  def run
    puts "Игра блэкджек."
    name = nil
    loop do
      print "Введите свое имя: "
      name = gets.chomp
      if name.nil? or name.empty?
        puts "В не указали свое имя. Попробуйте еще раз."
      else
        break
      end
    end
    @human.name = name
    begin
      start
      loop do
        @player = @iter_players.next
        show_cards
        action_id = @player.run(@deck)
        case action_id
          when :pass then puts "#{@player} пропускает"
          when :add_card then puts "#{@player} берет карту"
          when :game_break
            puts "Игра прервана"
            break
        end
        if action_id == :game_end or game_end?
          show_winner
          if next_play?
            start
          else
            break
          end
        end
        sleep 1
      end
    rescue NotEnoughMoney => e
      puts "[#{e.player}] #{e.message}"
      winner = e.player==@human ? @android : @human
      show_winner(winner)
      if next_play?
        @human.bank.amount = START_BANK
        @android.bank.amount = START_BANK
        sleep 3
        retry
      end
    end
  end

  private

  def start
    @iter_players = @players.cycle
    @deck.fill
    @human.clear_cards
    @android.clear_cards
    2.times do
      @human << @deck.shift
      @android << @deck.shift
    end
    @bank << @human.withdraw_money(@rate)
    @bank << @android.withdraw_money(@rate)
  end

  def next_play?
    menu = {
        1=> "Сыграть еще раз",
        2=> "Выйти"
    }
    menu_id = Utils.show_menu_with_select(menu)
    menu_id == 1
  end

  def show_winner(winner1=nil)
    winner = winner1 || @players.select{|x| !x.lost?}.max_by{|x| x.score}
    if winner1.nil? and (winner.nil? or @human.score==@android.score)
      puts "Ничья"
      amount = @bank.to_i/2
      @bank.transfer(@human.bank, amount)
      @bank.transfer(@android.bank, amount)
    else
      @bank.transfer(winner.bank, @bank.to_i)
      puts "Выиграл #{winner}"
    end
    show_cards(true)
  end

  def show_cards(visible=false)
    puts "Банк игры: #{@bank.to_i}"
    puts "#{@human}, #{@human.show_cards(true)}, score: #{@human.score}, bank: #{@human.bank.to_i}"
    puts "#{@android}, #{@android.show_cards(visible)}" + (visible ? ", score: #{@android.score}" : '') + ", bank: #{@android.bank.to_i}"
  end

  def game_end?
    @players.select {|player| player.win?}.any? or @players.select {|player| player.game_end?}.length == @players.length
  end
end

if __FILE__==$0
  main = Main.new
  main.run
end