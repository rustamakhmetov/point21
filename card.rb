# -*- encoding: utf-8 -*-

class Card
  SIMPLE = :simple
  PICTURE = :picture
  ACE = :ace

  attr_reader :nominal, :type

  def initialize(lear, type, nominal, symbol = nil)
    @nominal = nominal
    @type = type
    @lear = lear
    @symbol = symbol || @nominal
  end

  def ace?
    @type == Card::ACE
  end

  def to_s
    "#{@symbol}#{@lear}"
  end
end
