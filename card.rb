# -*- encoding: utf-8 -*-

class Card
  SIMPLE = :simple
  PICTURE = :picture
  ACE = :ace

=begin
  «В» = «J» — Jack
  «Д» = «Q» — Queen
  «К» = «K» — King
  «Т» = «A» — Ace
=end

  def initialize(lear, type, nominal, symbol=nil)
    @nominal = nominal
    @type = type
    @lear = lear
    @symbol = @nominal if symbol.nil?
  end

  def to_s
    "#{@symbol}#{@lear}"
  end
end