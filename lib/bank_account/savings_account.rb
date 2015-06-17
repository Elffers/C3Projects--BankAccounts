class SavingsAccount < Account

  TRANSACTION_FEE = 2
  MINIMUM_BALANCE = 10

  class MinimumBalanceError < StandardError; end

  def initialize id, initial_balance
    check_minimum_balance initial_balance
    super
  end

  def add_interest rate
    self.balance = self.balance*(1 + rate/100)
  end

  private

  def check_minimum_balance balance
    raise ArgumentError if balance < MINIMUM_BALANCE
  end

  # overrides parent private method, called from inherited #withdraw method
  def check_withdrawal amount
    max_withdrawal = self.balance - MINIMUM_BALANCE
    if amount > max_withdrawal
      raise MinimumBalanceError, "You only can withdraw $#{max_withdrawal}!"
    end
  end
end
