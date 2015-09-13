# -*- encoding: utf-8 -*-

class NotEnoughMoney < StandardError
  attr_reader :player, :message
  def initialize(player, ex)
    @player = player
    @message = ex.message
  end
end