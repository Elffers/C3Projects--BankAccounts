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
end
