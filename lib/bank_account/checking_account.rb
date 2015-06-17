module Account
  class CheckingAccount < Account

    attr_accessor :checks_used, :month

    TRANSACTION_FEE = 1
    MONTHLY_FREE_CHECKS = 3
    OVERDRAFT_MAX = 10
    CHECK_WITHDRAWAL_FEE = 2

    class OverdraftError < StandardError; end

    def initialize id, initial_balance
      @checks_used = 0
      @month = current_month
      super
    end

    def reset_checks
      @checks_used = 0
    end

    def withdraw_using_check amount
      check_for_overdraft amount
      calculate_fee
      self.balance -= amount
    end

    private

    def calculate_fee
      used_checks_count = checks_used_this_month
      if used_checks_count >= MONTHLY_FREE_CHECKS
        deduct_check_withdrawal_fee
      end

      self.checks_used += 1
    end

    def check_for_overdraft amount
      max_withdrawal = self.balance + OVERDRAFT_MAX
      if amount > max_withdrawal
        raise OverdraftError, "You only can withdraw $#{max_withdrawal}!"
      end
    end

    def checks_used_this_month
      if current_month != @month
        @month = current_month
        reset_checks
      else
        @checks_used
      end
    end

    def deduct_check_withdrawal_fee
      self.balance -= CHECK_WITHDRAWAL_FEE
    end

    def current_month
      Time.now.month
    end
  end
end
