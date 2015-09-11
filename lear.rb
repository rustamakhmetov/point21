# -*- encoding: utf-8 -*-

class Lear
  CLUBS = (Class.new do
    def to_s
      "+"
    end
  end).new
  DIAMONDS = (Class.new do
    def to_s
      "<>"
    end
  end).new
  HEARTS = (Class.new do
    def to_s
      "<3"
    end
  end).new
  SPADES = (Class.new do
    def to_s
      "^"
    end
  end).new

  def self.all
    [CLUBS, DIAMONDS, HEARTS, SPADES]
  end
end