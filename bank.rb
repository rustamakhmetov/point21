class Bank
  attr_writer :amount

  def initialize(amount=0)
    @amount = amount
  end

  def <<(amount)
    @amount+=amount
  end

  def >>(amount)
    raise "Недостаточно баланса для списания #{amount} долларов" if amount>@amount
    @amount-=amount
  end

  def transfer(bank, amount)
    self >> amount
    bank << amount
  end

  def to_i
    @amount
  end
end