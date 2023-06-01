require 'minitest/autorun'
require_relative '../lib/gate'
require_relative '../lib/ticket'
require_relative '../lib/suica'

class GateTest < Minitest::Test
  def setup
    @umeda = Gate.new(:umeda)
    @juso = Gate.new(:juso)
    @mikuni = Gate.new(:mikuni)
  end

  def test_umeda_to_juso
    ticket = Ticket.new(160)
    @umeda.enter(ticket)
    assert @juso.exit(ticket)
  end

  def test_umeda_to_mikuni_when_fare_is_not_enough
    ticket = Ticket.new(160)
    @umeda.enter(ticket)
    refute @mikuni.exit(ticket)
  end

  def test_umeda_to_mikuni_when_fare_is_enough
    ticket = Ticket.new(190)
    @umeda.enter(ticket)
    assert @mikuni.exit(ticket)
  end

  def test_juso_to_mikuni
    ticket = Ticket.new(160)
    @juso.enter(ticket)
    assert @mikuni.exit(ticket)
  end

  def test_umeda_to_juso_by_suica
    suica = Suica.new(1000)
    @umeda.enter_by_suica(suica)
    assert @juso.exit_by_suica(suica)
    assert_equal 840, suica.balance
  end
  
  def test_umeda_to_juso_by_suica_when_balance_is_100
    suica = Suica.new(100)
    @umeda.enter_by_suica(suica)
    refute @juso.exit_by_suica(suica)
    assert_equal 100, suica.balance

  end
end
