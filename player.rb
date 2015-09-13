# -*- encoding: utf-8 -*-

require_relative 'bank'

class Player
  attr_accessor :name, :bank
  attr_reader :score

  def initialize(name=nil, bank_amount)
    @name = name
    @bank = Bank.new(bank_amount)
    @cards = []
    @score = 0
  end

  def show_cards(visible)
    if visible
      @cards.join(" ")
    else
      (["*"]*@cards.length).join(" ")
    end
  end

  def run
    :game_end if game_end?
  end

  def lost?
    @scores>21
  end

  def <<(card)
    @cards << card
    if card.ace?
      if @score<=10
        @score += card.nominal
      else
        @score +=1
      end
    else
      @score += card.nominal
    end
  end

  def withdraw_money(amount)
    @bank >> amount
    amount
  rescue RuntimeError => e
    raise "[#{self}] #{e.message}"
  end

  def deposit_money(amount)
    @bank << amount
    @bank.to_i
  end

  def to_s
    @name
    #"#{@name} [#{show_cards}] => #{@score}"
  end

  protected

  def add_card(deck)
    self << deck.shift
  end

  def game_end?
    @cards.length==3 or @score>=21
  end

end