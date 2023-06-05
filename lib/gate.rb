class Gate
  STATIONS = [:umeda, :juso, :mikuni]
  FARES = [160, 190]

  def initialize(name)
    @name = name
  end

  def enter(ticket)
    ticket.stamp(@name)
  end

  def exit(ticket)
    fare = calc_fare(ticket)
    fare <= ticket.fare
  end
  
  def enter_by_suica(suica)
    if suica.balance > 0
      suica.stamp(@name)
    else
      false
    end
  end
  
  def exit_by_suica(suica)
    fare = calc_fare(suica)
  
    suica.discharge(fare)
  end

  def calc_fare(ticket)
    from = STATIONS.index(ticket.stamped_at)
    to = STATIONS.index(@name)
    distance = to - from
    FARES[distance - 1]
  end
end
