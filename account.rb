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

class SavingsAccount < Account

  MINIMUM_BALANCE = 10

  class MinimumBalanceError < StandardError; end

  def initialize id, initial_balance
    check_minimum_balance initial_balance
    super
  end

  def add_interest rate
    self.balance = self.balance*(1 + rate/100)
  end

  def withdraw amount
    check_withdrawal amount
    deduct_transaction_fee
    super
  end

  private

  def check_minimum_balance balance
    raise ArgumentError if balance < MINIMUM_BALANCE
  end

  def check_withdrawal amount
    max_withdrawal = self.balance - MINIMUM_BALANCE
    if amount > max_withdrawal
      raise MinimumBalanceError, "You only can withdraw $#{max_withdrawal}!"
    end
  end

  def deduct_transaction_fee
    self.balance -= 2
  end

end
