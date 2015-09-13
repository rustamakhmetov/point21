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
      (2..10).each do |nominal|
        @cards << Card.new(lear, Card::SIMPLE, nominal)
      end
      %w(J Q K).each do |symbol|
        @cards << Card.new(lear, Card::PICTURE, 10, symbol)
      end
      @cards << Card.new(lear, Card::ACE, 11, 'A')
    end
    shuffle!
  end

  def shuffle!
    @cards.shuffle!
  end

  def shift
    @cards.shift
  end

end