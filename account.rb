# It should include the following new methods:

# #add_interest(rate): Calculate the interest on the balance and add the interest to the balance. Return the interest that was calculated and added to the balance (not the updated balance).
# Input rate is assumed to be a percentage (i.e. 0.25).
# The formula for calculating interest is balance * rate/100
# Example: If the interest rate is 0.25% and the balance is $10,000, then the interest is $25 and the new balance becomes $10,025.
#
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
