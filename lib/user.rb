class User

  #has_many tweets
  attr_accessor :name, :id

  def initialize(attr_hash)
    attr_hash.each {|key, value| self.send("#{key}=", value)}
  end

  def save
    if @id
      sql = "UPDATE users SET name = ? WHERE id = ?"
      DB.execute(sql, self.name, self.id)
    else
      sql = "INSERT INTO users (name) VALUES (?)"
      DB.execute(sql, self.name)
      @id = DB.execute("SELECT last_insert_rowid() FROM users")[0][0]
    end
  end

  def tweets
    sql = "SELECT * FROM tweets WHERE user_id = ?"
    array_of_tweet_hashes = DB.execute(sql, self.id)
    array_of_tweet_hashes.map {|tweet_hash| Tweet.new(tweet_hash)}
  end

  def self.all
    sql = "SELECT * FROM users"
    array_of_user_hashes = DB.execute(sql)
    #binding.pry
    array_of_user_hashes.map {|user_row_hash| User.new(user_row_hash)}
  end

  def self.setup_table
    sql = "CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, name TEXT)"
    DB.execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE users"
    DB.execute(sql)
  end


end
