class Player
  attr_accessor :name
  attr_reader :score

  def initialize(name=nil, bank)
    @name = name
    @bank = bank
    @cards = []
    @score = 0
  end

  def <<(card)
    @cards << card
    if card.ace?
      if @score<=10
        @score += card.nominal
      else
        @score +=1
      end
    else
      @score += card.nominal
    end
  end

  def show_cards(visible)
    if visible
      @cards.join(" ")
    else
      (["*"]*@cards.length).join(" ")
    end
  end

  def to_s
    @name
    #"#{@name} [#{show_cards}] => #{@score}"
  end
end