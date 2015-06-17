require 'timecop'

module Account
  describe CheckingAccount do
    describe '.initialize' do
      let(:account) { CheckingAccount.new(1, 10) }
      it "has an id and initial balance" do
        expect(account.id).to eq 1
        expect(account.initial_balance).to eq 10
      end

      it "cannot have a negative balance" do
        expect{ CheckingAccount.new(1, -10) }.to raise_error ArgumentError
      end

      it "can have an initial balance of 0" do
        account = CheckingAccount.new 1, 0
        expect(account.initial_balance).to eq 0
      end

      it "sets current month" do
        now = Time.new(2015, 5, 1)
        Timecop.freeze(now)
        account = CheckingAccount.new 1, 100
        expect(account.month).to eq 5
      end
    end

    describe '#withdraw' do
      let(:account) { CheckingAccount.new(1, 100) }
      it "subtracts amount from balance" do
        account.withdraw 10
        expect(account.balance).to eq 89
        account.withdraw 15
        expect(account.balance).to eq 73
      end

      it "does not allow balance to go negative" do
        expect { account.withdraw 110 }.to raise_error Account::NegativeBalanceError, "You only can withdraw $100!"
        expect(account.balance).to eq 100
      end
    end

    describe '#withdraw_using_check' do
      let(:account) { CheckingAccount.new(1, 100) }
      it "deducts amount from balance" do
        account.withdraw_using_check 10
        expect(account.balance).to eq 90
      end

      it "allows overdraft of up to -$10" do
        account.withdraw_using_check 10
        expect(account.balance).to eq 90
        account.withdraw_using_check 100
        expect(account.balance).to eq(-10)
      end

      it "does not allow overdraft of over -$10" do
        expect { account.withdraw_using_check 120 }.to raise_error CheckingAccount::OverdraftError, "You only can withdraw $110!"
        expect(account.balance).to eq 100
      end

      it "allows three free check withdrawals per month" do
        start_of_month = Time.new(2015, 3, 1)
        within_month_1 = Time.new(2015, 3, 2)
        within_month_2 = Time.new(2015, 3, 3)
        within_month_3 = Time.new(2015, 3, 4)
        within_month_4 = Time.new(2015, 3, 5)
        next_month_1 = Time.new(2015, 4, 1)
        next_month_2 = Time.new(2015, 4, 2)

        Timecop.freeze(start_of_month)

        Timecop.travel(within_month_1)
        account.withdraw_using_check 10
        expect(account.balance).to eq 90

        Timecop.travel(within_month_2)
        account.withdraw_using_check 10
        expect(account.balance).to eq 80

        Timecop.travel(within_month_3)
        account.withdraw_using_check 10
        expect(account.balance).to eq 70

        Timecop.travel(within_month_4)
        account.withdraw_using_check 10
        expect(account.balance).to eq 58

        Timecop.travel(next_month_1)
        account.withdraw_using_check 10
        expect(account.balance).to eq 48

        Timecop.travel(next_month_2)
        account.withdraw_using_check 10
        expect(account.balance).to eq 38
      end
    end

    describe "#reset_checks" do
      let(:account) { CheckingAccount.new(1, 10) }
      it "sets number of checks used to 0" do
        expect(account.checks_used).to eq 0
        account.withdraw_using_check 10
        expect(account.checks_used).to eq 1
        account.reset_checks
        expect(account.checks_used).to eq 0
      end
    end
  end
end
