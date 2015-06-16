describe SavingsAccount do
  describe ".initialize" do
    it "has an id and initial balance" do
      account = SavingsAccount.new 1, 100
      expect(account.id).to eq 1
      expect(account.initial_balance).to eq 100
    end

    it "cannot have a negative balance" do
      expect{ SavingsAccount.new(1, -10) }.to raise_error ArgumentError
    end

    it "cannot have an initial balance of 0" do
      expect{ SavingsAccount.new(1, 0) }.to raise_error ArgumentError
    end
  end

  describe '.withdraw' do
    let(:account) { SavingsAccount.new(1, 100) }
    it "subtracts amount from balance" do
      account.withdraw 10
      expect(account.balance).to eq 88
      account.withdraw 15
      expect(account.balance).to eq 71
    end

    it "does not allow balance to go below $10" do
      expect { account.withdraw 100 }.to raise_error SavingsAccount::MinimumBalanceError, "You only can withdraw $90!"
      expect(account.balance).to eq 100
    end
  end

  describe '.add_interest' do
    let(:account) { SavingsAccount.new(1, 10_000) }
    it "adds interest to current balance" do
      account.add_interest(0.25)
      expect(account.balance).to eq 10_025
    end
  end
end
