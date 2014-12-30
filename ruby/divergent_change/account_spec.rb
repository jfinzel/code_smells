require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'active_support/core_ext/date'
require 'pry'

Dir["./*.rb"].each {|file| require file }

describe Account do

  describe 'checking account' do
    before do 
      @account = Account.new(:checking, 1000, 0.01)
    end
    it 'withdraws' do
      @account.withdraw(300)
      @account.balance.must_equal 700
    end
    it 'deposits' do
      @account.deposit(300)
      @account.balance.must_equal 1300
    end

  end

  describe 'savings account' do
    before do 
      @account = Account.new(:savings, 1000, 0.01)
    end
    it 'withdraws' do
      @account.withdraw(300)
      @account.balance.must_equal 700
    end
    it 'deposits' do
      @account.deposit(300)
      @account.balance.must_equal 1300
    end
  end

  describe 'CD account' do
    before do
      @account = Account.new(:cd, 1000, 0.01, Date.tomorrow)
    end

    it 'deposits' do
      @account.deposit(300)
      @account.balance.must_equal 1300
    end

    it 'errors on premature withdraws' do
      lambda {@account.withdraw(300)}.must_raise(ImmatureFundsException)
    end
  end

  describe 'money market account' do
    before do
      @account = nil
    end

    it 'deposits' do
      @account.deposit(300)
      fail
    end

    it 'allows interest changes' do
      @account.interest_rate = 0.08
      @account.interest_rate.must_equal 0.08
    end

    it 'withdraws' do
      @account.withdraw(300)
    end

    it 'errors on balance < min balance' do
      lambda {@account.withdraw('some money')}.must_raise(MinBalanceException)
    end
  end
end
