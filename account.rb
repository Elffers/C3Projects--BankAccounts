# Create an Account class with a minimum of 6 specs. The class should have the following methods:

# #deposit(amount): Adds the input amount to the account balance as a result of an ATM transaction. Return value should be the updated account balance
# #balance: Returns the current account balance
# Create a SavingsAccount class with a minimum of 6 specs. The class should inherit behavior from the Account class. It should include updated logic within the following methods:

# self.new(id, initial_balance): creates a new instance with the instance variable id and 'initial_balance' assigned
# The initial balance cannot be less than $10. If it is, this will raise an ArgumentError
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
