# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create( username: 'martin_admin', password: 'changeme', email: 'martin@admin.com', user_level: 1)
User.create( username: 'martin_t', password: 'changeme', email: 'martin@teller.com', user_level: 2)
User.create( username: 'martin_c', password: 'changeme', email: 'martin@customer.com', user_level: 3)
