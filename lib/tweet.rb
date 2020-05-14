class Tweet

  #belongs_to user

  attr_accessor :message, :user_id, :id

  # @@all = []

  def initialize(attr_hash)
    attr_hash.each {|key, value| self.send("#{key}=", value)}
    # @@all << self
  end

  def save
    if @id
      sql = "UPDATE tweets SET message = ? WHERE id = ?"
      DB.execute(sql, self.message, self.id)
    else
      sql = "INSERT INTO tweets (message, user_id) VALUES (?, ?)"
      DB.execute(sql, self.message, self.user_id)
      @id = DB.execute("SELECT last_insert_rowid() FROM tweets")[0][0]
    end
  end

  def user
    sql = "SELECT * FROM users WHERE id = ?"
    array_of_one_single_user_hash = DB.execute(sql, self.user_id)
    User.new(array_of_one_single_user_hash[0])
  end

  def self.all
    sql = "SELECT * FROM tweets"
    array_of_tweet_hashes = DB.execute(sql)
    binding.pry
    array_of_tweet_hashes.map {|tweet_row_hash| Tweet.new(tweet_row_hash)}
  end

  def self.setup_table
    sql = "CREATE TABLE IF NOT EXISTS tweets (id INTEGER PRIMARY KEY, user_id INTEGER, message TEXT)"
    DB.execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE tweets"
    DB.execute(sql)
  end

end
