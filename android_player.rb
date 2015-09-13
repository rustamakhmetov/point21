# -*- encoding: utf-8 -*-

require_relative 'player'

class AndroidPlayer < Player
  def run(deck)
    return :pass if @score>=18
    add_card(deck)
  end
end