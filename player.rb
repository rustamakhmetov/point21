# -*- encoding: utf-8 -*-

require_relative 'bank'
require_relative 'not_enough_money'

class Player
  attr_accessor :name, :bank
  attr_reader :score

  def initialize(name, bank_amount)
    @name = name
    @bank = Bank.new(bank_amount)
    clear_cards
  end

  def show_cards(visible)
    if visible
      @cards.join(' ')
    else
      (['*'] * @cards.length).join(' ')
    end
  end

  def run
    #:game_end if game_end?
    false
  end

  def lost?
    @score > 21
  end

  def win?
    @score == 21
  end

  def <<(card)
    @cards << card
    if card.ace?
      if @score <= 10
        @score += card.nominal
      else
        @score += 1
      end
    else
      @score += card.nominal
    end
  end

  def withdraw_money(amount)
    @bank >> amount
    amount
  rescue RuntimeError => e
    # raise "[#{self}] #{e.message}"
    raise NotEnoughMoney.new(self, e)
  end

  def deposit_money(amount)
    @bank << amount
    @bank.to_i
  end

  def clear_cards
    @cards = []
    @score = 0
    @pass_count = 0
  end

  def game_end?
    @cards.length >= 3
  end

  def show_state(visible = true)
    state = "#{self}, #{show_cards(visible)}"
    state += ", score: #{@score}" if visible
    state += ", bank: #{@bank.to_i}"
    puts state
  end

  def input_name
    loop do
      print 'Введите свое имя: '
      @name = gets.chomp
      if @name.nil? || @name.empty?
        puts 'В не указали свое имя. Попробуйте еще раз.'
      else
        break
      end
    end
    @name
  end

  def to_s
    @name
  end

  protected

  def add_card(deck)
    self << deck.shift
    :add_card
  end
end
