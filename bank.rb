class Bank
  attr_writer :amount

  def initialize(amount = 0)
    @amount = amount
  end

  def <<(other)
    @amount += other
  end

  def >>(other)
    message = "Недостаточно баланса для списания #{other} долларов"
    fail message if other > @amount
    @amount -= other
  end

  def transfer(bank, amount)
    self >> amount
    bank << amount
  end

  def to_i
    @amount
  end
end
