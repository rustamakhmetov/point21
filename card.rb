class Card
  def initialize(lear, nominal, symbol=nil)
    @nominal = nominal
    @lear = lear
    @symbol = @nominal if symbol.nil?
  end

  def to_s
    "#{@symbol}#{@lear}"
  end
end