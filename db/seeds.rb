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

admin = User.create( username: 'martin_a', password: 'changeme', email: 'martin@admin.com', user_level: 1)
teller = User.create( username: 'martin_t', password: 'changeme', email: 'martin@teller.com', user_level: 2)
customer = User.create( username: 'martin_c', password: 'changeme', email: 'martin@customer.com', user_level: 3)
customer_checking = Checking.create( user_id: customer.id, balance_string: '0.00', is_active: true)


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
   #Deposit.create( user_id: teller.id, account_id: checking.id, amount_string: rand(1000).to_s)
   #Deposit.create( user_id: teller.id, account_id: market.id, amount_string: rand(1000).to_s, created_at: time_rand)
   #Deposit.create( user_id: teller.id, account_id: mortgage.id, amount_string: rand(1000).to_s, created_at: time_rand)
   #Deposit.create( user_id: teller.id, account_id: credit.id, amount_string: rand(1000).to_s, created_at: time_rand)
   #Deposit.create( user_id: teller.id, account_id: saving.id, amount_string: rand(1000).to_s, created_at: time_rand)
 end
 (1..10).each do |f|
   #withdrawal_time = time_rand
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
   #Withdrawal.create( user_id: teller.id, account_id: market.id, amount_string: rand(1000).to_s, created_at: time_rand)
   #Withdrawal.create( user_id: teller.id, account_id: mortgage.id, amount_string: rand(1000).to_s, created_at: time_rand)
   #Withdrawal.create( user_id: teller.id, account_id: credit.id, amount_string: rand(1000).to_s, created_at: time_rand)
   #Withdrawal.create( user_id: teller.id, account_id: saving.id, amount_string: rand(1000).to_s, created_at: time_rand)
 end
end 
