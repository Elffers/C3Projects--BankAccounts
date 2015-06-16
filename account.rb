# #withdraw(amount): The input amount gets taken out of the account as result of an ATM transaction. Each withdrawal 'transaction' incurs a fee of $2 that is taken out of the balance.
# Does not allow the account to go below the $10 minimum balance - Will output a warning message and return the original un-modified balance
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
  def initialize id, initial_balance
    check_minimum_balance initial_balance
    super
  end

  private

  def check_minimum_balance balance
    raise ArgumentError if balance < 10
  end
end
