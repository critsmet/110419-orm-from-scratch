require_relative '../config/environment.rb'
#require_relative '../db/seeds.rb'

binding.pry
0

chris = User.new(name: "Chris")
chris.name = "Christopher"
chris.save

chris.update(name: "Christopher")
