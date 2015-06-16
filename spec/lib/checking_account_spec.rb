describe CheckingAccount do
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
