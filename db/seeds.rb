# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def time_rand from = 0.0, to = Time.now
  return Time.at(from + rand * (to.to_f - from.to_f))
end

def string_rand
 o = [('a'..'z'), ('A'..'Z')].map { |d| d.to_a }.flatten
 string = (0...50).map { o[rand(o.length)] }.join
 return string
end

# Initial user setup  
admin = User.create( username: 'bmu_a', password: 'changeme', email: 'bmu@admin.com', user_level: 1)
teller = User.create( username: 'bmu_t', password: 'changeme', email: 'bmu@teller.com', user_level: 2)
customer = User.create( username: 'bmu_c', password: 'changeme', email: 'bmu@customer.com', user_level: 3)
customer_checking = Checking.create( user_id: customer.id, balance_string: '0.00', is_active: true)

# Test 1 rates()
# Test 1.1 Credit rate()
user = User.create( username: 'test_1_1', password: 'changeme', user_level: 3)
two_months = DateTime.now - 2.months
credit = Credit.create( user_id: user.id, balance_string: '1000.00', monthly_account_rate: 0.1, is_active: true, created_at: two_months, updated_at: two_months )
# Test 1.2 Market rate()
user = User.create( username: 'test_1_2', password: 'changeme', user_level: 3)
market = Market.create( user_id: user.id, balance_string: '1000.00', monthly_account_rate: 0.2, is_active: true, created_at: two_months, updated_at: two_months )
# Test 1.3 Mortgage rate()
one_year = DateTime.now - 30.years
# Test 1.3.1 : Makes correct monthly payments 
user = User.create( username: 'test_1_3_1', password: 'changeme', user_level: 3)
mortgage = Mortgage.create( user_id: user.id, balance_string: '200,000.00', monthly_account_rate: 500, is_active: true, created_at: one_year, updated_at: one_year )
(1..360).each do |i|
  deposit = Deposit.new( user_id: teller.id, account_id: mortgage.id, transaction_type: 'Deposit', amount_string: '500', created_at: (DateTime.now - i.months), updated_at: (DateTime.now - i.months))
  deposit.deposit()
end
# Test 1.3.2 : Makes incorrect monthly payments  (fails on behin)
user = User.create( username: 'test_1_3_2', password: 'changeme', user_level: 3)
mortgage = Mortgage.create( user_id: user.id, balance_string: '200,000.00', monthly_account_rate: 500, is_active: true, created_at: one_year, updated_at: one_year )
(1..360).each do |i|
  deposit = Deposit.new( user_id: teller.id, account_id: mortgage.id, transaction_type: 'Deposit', amount_string: '499', created_at: (DateTime.now - i.months), updated_at: (DateTime.now - i.months))
  deposit.deposit()
end
# Test 1.3.3 : Makes large correct payments every two months
user = User.create( username: 'test_1_3_3', password: 'changeme', user_level: 3)
mortgage = Mortgage.create( user_id: user.id, balance_string: '200,000.00', monthly_account_rate: 500, is_active: true, created_at: one_year, updated_at: one_year )
(1..180).each do |i|
  i = i*2
  deposit = Deposit.new( user_id: teller.id, account_id: mortgage.id, transaction_type: 'Deposit', amount_string: '1000', created_at: (DateTime.now - i.months), updated_at: (DateTime.now - i.months))
  deposit.deposit()
end
# Test 1.3.4 : Mortgage payments are complete
user = User.create( username: 'test_1_3_4', password: 'changeme', user_level: 3)
mortgage = Mortgage.create( user_id: user.id, balance_string: '200,000.00', monthly_account_rate: 500, is_active: true, created_at: one_year, updated_at: one_year)
deposit = Deposit.new( user_id: teller.id, account_id: mortgage.id, transaction_type: 'Deposit', amount_string: '200,000.00', created_at: one_year, updated_at: one_year)
deposit.deposit()
# Test 1.3.5 : Haven't paid mortgage this month.
user = User.create( username: 'test_1_3_5', password: 'changeme', user_level: 3)
mortgage = Mortgage.create( user_id: user.id, balance_string: '200,000.00', monthly_account_rate: 500, is_active: true, created_at: one_year, updated_at: one_year )
(1..359).each do |i|
  deposit = Deposit.new( user_id: teller.id, account_id: mortgage.id, transaction_type: 'Deposit', amount_string: '500', created_at: (DateTime.now - i.months), updated_at: (DateTime.now - i.months))
  deposit.deposit()
end
# Test 1.3.6 : Haven't paid mortgage for two months.
user = User.create( username: 'test_1_3_6', password: 'changeme', user_level: 3)
mortgage = Mortgage.create( user_id: user.id, balance_string: '200,000.00', monthly_account_rate: 500, is_active: true, created_at: one_year, updated_at: one_year )
(1..358).each do |i|
  deposit = Deposit.new( user_id: teller.id, account_id: mortgage.id, transaction_type: 'Deposit', amount_string: '500', created_at: (DateTime.now - i.months), updated_at: (DateTime.now - i.months))
  deposit.deposit()
end
# Test 1.4 Saving rate()
user = User.create( username: 'test_1_4', password: 'changeme', user_level: 3)
saving = Saving.create( user_id: user.id, balance_string: '1000.00', monthly_account_rate: 0.4, is_active: true, created_at: two_months, updated_at: two_months )
# Test 1.5 Checking rate()
user = User.create( username: 'test_1_5', password: 'changeme', user_level: 3)
checking = Checking.create( user_id: user.id, balance_string: '1000.00', is_active: true, created_at: two_months, updated_at: two_months )

# Test 2 Bills
user = User.create( username: 'test_2', password: 'changeme', user_level: 3)
checking = Checking.create( user_id: user.id, balance_string: '1000.00', is_active: true, created_at: two_months, updated_at: two_months )
# Test 2.1 One Time Bill Payment
bill = Bill.create( pay_date: Date.today, amount_string: '25.00', 
                    user_id: user.id, account_id: checking.id, is_recurring: false, 
                    payee_name: 'test_user', payee_street: 'something blvd', 
                    payee_city: 'madison', payee_state: 'AL', payee_zip: 35806, 
                    payee_account_id: customer_checking.id)
# Test 2.2 Recurring Bill Payments
bill = Bill.create( pay_date: Date.today, amount_string: '25.00', 
                    user_id: user.id, account_id: checking.id, is_recurring: true, 
                    payee_name: 'test_user', payee_street: 'something blvd', 
                    payee_city: 'madison', payee_state: 'AL', payee_zip: 35806, 
                    payee_account_id: customer_checking.id,
                    created_at: (DateTime.now - 12.months), updated_at: (DateTime.now - 12.months))
                     
# Extra Sample Data 
=begin
(1..10).each do |i|
 o = [('a'..'z'), ('A'..'Z')].map { |d| d.to_a }.flatten
 string = (0...50).map { o[rand(o.length)] }.join
 user = User.create( username: string, password: 'changeme', user_level: 3)
 checking = Checking.create( user_id: user.id, balance_string: '0.00', is_active: true )
 credit = Credit.create( user_id: user.id, balance_string: '0.00', monthly_account_rate: 0.1, is_active: true )
 market = Market.create( user_id: user.id, balance_string: '0.00', monthly_account_rate: rand, is_active: true )
 mortgage = Mortgage.create( user_id: user.id, balance_string: '0.00', monthly_account_rate: 0.3, is_active: true )
 saving = Saving.create( user_id: user.id, balance_string: '0.00', monthly_account_rate: 0.02, is_active: true)
 bill = Bill.create( pay_date: Date.tomorrow, amount_string: (1 + rand(1000)).to_s, 
                     user_id: user.id, account_id: checking.id, is_recurring: true, 
                     payee_name: 'martin', payee_street: 'something blvd', 
                     payee_city: 'madison', payee_state: 'AL', payee_zip: 35806, 
                     payee_account_id: customer_checking.id)
 (1..15).each do |e|
   deposit = Deposit.new( user_id: teller.id, account_id: checking.id, amount_string: (1 + rand(1000)).to_s)
   deposit.deposit
   deposit = Deposit.new( user_id: teller.id, account_id: market.id, amount_string: (1 + rand(1000)).to_s)
   deposit.deposit
   deposit = Deposit.new( user_id: teller.id, account_id: mortgage.id, amount_string: (1 + rand(1000)).to_s)
   deposit.deposit
   deposit = Deposit.new( user_id: teller.id, account_id: credit.id, amount_string: (1 + rand(1000)).to_s)
   deposit.deposit
   deposit = Deposit.new( user_id: teller.id, account_id: saving.id, amount_string: (1 + rand(1000)).to_s)
   deposit.deposit
 end
 (1..10).each do |f|
   withdrawal = Withdrawal.new( user_id: teller.id, account_id: checking.id, amount_string: (1 + rand(1000)).to_s)
   withdrawal.withdrawal
   withdrawal = Withdrawal.new( user_id: teller.id, account_id: market.id, amount_string: (1 + rand(1000)).to_s)
   withdrawal.withdrawal
   withdrawal = Withdrawal.new( user_id: teller.id, account_id: mortgage.id, amount_string: (1 + rand(1000)).to_s)
   withdrawal.withdrawal
   withdrawal = Withdrawal.new( user_id: teller.id, account_id: credit.id, amount_string: (1 + rand(1000)).to_s)
   withdrawal.withdrawal
   withdrawal = Withdrawal.new( user_id: teller.id, account_id: saving.id, amount_string: (1 + rand(1000)).to_s)
   withdrawal.withdrawal
 end
end 
=end
