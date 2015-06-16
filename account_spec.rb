require_relative 'account'

describe Account do

  describe '.initialize' do
    let(:account) { Account.new(1, 10) }
    it "has an id and initial balance" do
      expect(account.id).to eq 1
      expect(account.initial_balance).to eq 10
    end

    it "cannot have a negative balance" do
      expect{ Account.new(1, -10) }.to raise_error ArgumentError
    end
  end

  describe '.withdraw' do
    let(:account) { Account.new(1, 100) }
    it "subtracts amount from balance" do
      account.withdraw 10
      expect(account.balance).to eq 90
      account.withdraw 15
      expect(account.balance).to eq 75
    end

    it "does not allow balance to go negative" do
      expect { account.withdraw 110 }.to raise_error Account::NegativeBalanceError, "You only can withdraw $100!"
      expect(account.balance).to eq 100
    end
  end
end
