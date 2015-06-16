class Account
  attr_accessor :id, :initial_balance, :balance

  class NegativeBalanceError < StandardError; end

  def initialize(id, initial_balance)
    check_balance initial_balance

    @id = id
    @initial_balance = initial_balance
    @balance = initial_balance
  end

  def deposit amount
    @balance += amount
  end

  def withdraw amount
    check_withdrawal amount
    @balance -= amount
  end

  private

  def check_balance balance
    raise ArgumentError if balance < 0
  end

  def check_withdrawal amount
    if amount > self.balance
      raise NegativeBalanceError, "You only can withdraw $#{balance}!"
    end
  end
end
