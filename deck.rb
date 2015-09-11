require_relative 'simple_card'
require_relative 'lear'
class Deck
  def initialize
    @cards = []
    (2..10).each do |nominal|
      @cards << Card.new(Lear::SPADES, nominal)
      @cards << Card.new(Lear::CLUBS, nominal)
      @cards << Card.new(Lear::DIAMONDS, nominal)
      @cards << Card.new(Lear::HEARTS, nominal)
    end
    ['']

  end
end