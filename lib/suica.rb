class Suica
  attr_reader :balance, :stamped_at

  def initialize(balance)
    @balance = balance
  end

  def stamp(name)
    @stamped_at = name
  end

  def charge(value)
    if value > 0
      @balance += value
    else
      false
    end
  end

  def discharge(fare)
    if @balance - fare >= 0
      @balance -= fare
    else
      false
    end
  end
end
