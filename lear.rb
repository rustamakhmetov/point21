require_relative 'clubs_lear'
require_relative 'diamonds_lear'
require_relative 'hearts_lear'
require_relative 'spades_lear'

class Lear
  CLUBS = ClubsLear.new
  DIAMONDS = DiamondsLear.new
  HEARTS = HeartsLear.new
  SPADES = SpadesLear.new
end