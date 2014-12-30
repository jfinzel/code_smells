class Account
  attr_reader :type, :balance, :maturation_date, :interest_rate

  def initialize(type, balance, interest_rate, maturation_date = nil)
    throw UnknownAccountType unless [:cd, :savings, :checking].include?(type)
    @type = type
    @balance = balance
    @maturation_date = maturation_date
    @interest_rate = interest_rate
  end

  def withdraw(amount)
    raise ImmatureFundsException if (type == :cd && Date.today < maturation_date)
    raise OverdrawException if amount > @balance
    @balance -= amount
  end

  def deposit(amount)
    @balance += amount
  end
end

class ImmatureFundsException < RuntimeError
end
class OverdrawException < RuntimeError
end
class UnknownAccountType < RuntimeError
end
