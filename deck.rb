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
      ['J', 'Q', 'K'].each do |symbol|
        @cards << Card.new(lear, Card::PICTURE, 10, symbol)
      end
      @cards << Card.new(lear, Card::ACE, 10, "A")
    end
  end

  def shuffle
    @cards.shuffle!
  end
end