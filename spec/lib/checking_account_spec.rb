describe CheckingAccount do
  describe '#initialize' do
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
end
