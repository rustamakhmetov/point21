# -*- encoding: utf-8 -*-

require_relative 'card'
require_relative 'lear'

class Deck
  def initialize
    fill
  end

  def fill
    @cards = []
    Lear.all.each do |lear|
      (2..10).each { |nominal| add_card(lear, Card::SIMPLE, nominal) }
      %w(J Q K).each { |symbol| add_card(lear, Card::PICTURE, 10, symbol) }
      add_card(lear, Card::ACE, 11, 'A')
    end
    shuffle!
  end

  def add_card(lear, type, nominal, symbol = nil)
    @cards << Card.new(lear, type, nominal, symbol)
  end

  def shuffle!
    @cards.shuffle!
  end

  def shift
    @cards.shift
  end
end
