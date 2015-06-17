module Account
  class Account
    attr_accessor :id, :initial_balance, :balance

    TRANSACTION_FEE = 0

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
      deduct_transaction_fee
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

    def deduct_transaction_fee
      self.balance -= self.class::TRANSACTION_FEE
    end
  end
end
