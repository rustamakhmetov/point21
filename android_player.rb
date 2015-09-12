# -*- encoding: utf-8 -*-

require_relative 'player'

class AndroidPlayer < Player
  def run(deck)
    return :pass if @scores>18
    add_card(deck)
    super()
  end
end