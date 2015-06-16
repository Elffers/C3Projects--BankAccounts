# #withdraw_using_check(amount): The input amount gets taken out of the account as a result of a check withdrawal. Returns the updated account balance.
#
# Allows the account to go into overdraft up to -$10 but not any lower The
# user is allowed three free check uses in one month, but any subsequent use
# adds a $2 transaction fee
# #reset_checks: Resets the number of checks used to zero

class CheckingAccount < Account
  TRANSACTION_FEE = 1
end
