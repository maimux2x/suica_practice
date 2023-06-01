class Suica
  attr_accessor :balance, :stamped_at

  def initialize(balance)
    @balance = balance
  end

  def stamp(name)
    @stamped_at = name
  end
end
