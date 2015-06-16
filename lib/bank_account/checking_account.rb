# Create a CheckingAccount class with a minimum of 6 specs. The class should inherit behavior from the Account class.

# #withdraw(amount): The input amount gets taken out of the account as result of an ATM transaction. Each withdrawal 'transaction' incurs a fee of $1 that is taken out of the balance. Returns the updated account balance.
# Does not allow the account to go negative. Will output a warning message and return the original un-modified balance
# #withdraw_using_check(amount): The input amount gets taken out of the account as a result of a check withdrawal. Returns the updated account balance.
# Allows the account to go into overdraft up to -$10 but not any lower
# The user is allowed three free check uses in one month, but any subsequent use adds a $2 transaction fee
# #reset_checks: Resets the number of checks used to zero
