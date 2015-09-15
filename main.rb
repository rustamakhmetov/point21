#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

require_relative 'human_player'
require_relative 'android_player'
require_relative 'deck'
require_relative 'bank'
require_relative 'utils'
require_relative 'game_exit'

class Main
  START_BANK = 100
  def initialize
    @android = AndroidPlayer.new('Дилер', START_BANK)
    @human = HumanPlayer.new('Unknow', START_BANK)
    @players = [@human, @android]
    @deck = Deck.new
    @bank = Bank.new
    @rate = 10
  end

  def run
    puts 'Игра блэкджек.'
    @human.input_name
    begin
      manager
    rescue NotEnoughMoney => e
      puts "[#{e.player}] #{e.message}"
      retry if not_money(player)
    rescue GameExit => e
      puts e.message
    end
  end

  private

  def manager
    start
    loop do
      @player = @iter_players.next
      show_cards
      action_id = @player.run(@deck)
      send action_id if action_id
      send :game_end if game_end?
      sleep 1
    end
  end

  def not_money(player)
    winner = player == @human ? @android : @human
    show_winner(winner)
    if next_play?
      @human.bank.amount = START_BANK
      @android.bank.amount = START_BANK
      sleep 3
      true
    else
      false
    end
  end

  def game_end
    show_winner
    if next_play?
      start
    else
      fail GameExit
    end
  end

  def add_card
    puts "#{@player} берет карту"
  end

  def pass
    puts "#{@player} пропускает"
  end

  def game_break
    fail GameExit, 'Игра прервана'
  end

  def start
    @iter_players = @players.cycle
    @deck.fill
    @players.each do |player|
      player.clear_cards
      2.times do
        player << @deck.shift
      end
      @bank << player.withdraw_money(@rate)
    end
  end

  def next_play?
    menu = {
      1 => 'Сыграть еще раз',
      2 => 'Выйти'
    }
    menu_id = Utils.show_menu_with_select(menu)
    menu_id == 1
  end

  def show_winner(winner1 = nil)
    winner = winner1 || @players.select { |x| !x.lost? }.max_by(&:score)
    if winner1.nil? && (winner.nil? || @human.score == @android.score)
      puts 'Ничья'
      transfer_bank
    else
      transfer_bank winner
      puts "Выиграл #{winner}"
    end
    show_cards(true)
  end

  def transfer_bank(winner = nil)
    if winner
      @bank.transfer(winner.bank, @bank.to_i)
    else
      amount = @bank.to_i / 2
      @bank.transfer(@human.bank, amount)
      @bank.transfer(@android.bank, amount)
    end
  end

  def show_cards(visible = false)
    puts "Банк игры: #{@bank.to_i}"
    @human.show_state
    @android.show_state(visible)
  end

  def game_end?
    winner = @players.select(&:win?).any?
    winner || @players.count(&:game_end?) == @players.length
  end
end

if __FILE__ == $PROGRAM_NAME
  main = Main.new
  main.run
end
