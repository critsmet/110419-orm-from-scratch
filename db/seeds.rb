Tweet.drop_table
User.drop_table
Tweet.setup_table
User.setup_table

chris = User.new(name: "Chris")
chris.save
tweet1 = Tweet.new(message: "First Tweet", user_id: chris.id)
tweet1.save
