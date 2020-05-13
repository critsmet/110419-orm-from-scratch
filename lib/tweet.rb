class Tweet

  attr_accessor :message, :id

  # @@all = []

  def initialize(attr_hash)
    attr_hash.each {|key, value| self.send("#{key}=", value)}
    # @@all << self
  end

  def save
    sql = "INSERT INTO tweets (message) VALUES (?)"
    DB.execute(sql, self.message)
    @id = DB.execute("SELECT last_insert_rowid() FROM tweets")[0][0]
  end

  def self.all
    sql "SELECT * FROM tweets"
    array_of_tweet_hashes = DB.execute(sql)
    #binding.pry
    array_of_tweet_hashes.map {|tweet_row_hash| Tweet.new(tweet_row_hash)}
  end

  def self.setup_table
    sql = "CREATE TABLE IF NOT EXISTS tweets (id INTEGER PRIMARY KEY, message TEXT)"
    DB.execute(sql)
  end

end
