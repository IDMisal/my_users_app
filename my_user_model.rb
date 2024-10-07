require 'sqlite3'
require 'securerandom'

class User
  def initialize(db_name = "db.sql")
    @db = SQLite3::Database.new db_name
    create_table
  end

  def create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY,
        firstname TEXT,
        lastname TEXT,
        age INTEGER,
        password TEXT,
        email TEXT
      );
    SQL
    @db.execute(sql)
  end

  def create(user_info)
    sql = "INSERT INTO users (firstname, lastname, age, password, email) VALUES (?, ?, ?, ?, ?)"
    @db.execute(sql, user_info[:firstname], user_info[:lastname], user_info[:age], user_info[:password], user_info[:email])
    @db.last_insert_row_id
  end

  def find(user_id)
    sql = "SELECT * FROM users WHERE id = ?"
    result = @db.execute(sql, user_id).first
    user_hash(result)
  end

  def all
    sql = "SELECT * FROM users"
    result = @db.execute(sql)
    result.map { |user| user_hash(user) }
  end

  def update(user_id, attribute, value)
    sql = "UPDATE users SET #{attribute} = ? WHERE id = ?"
    @db.execute(sql, value, user_id)
    find(user_id)
  end

  def destroy(user_id)
    sql = "DELETE FROM users WHERE id = ?"
    @db.execute(sql, user_id)
  end

  private

  def user_hash(user_array)
    return nil unless user_array
    {
      id: user_array[0],
      firstname: user_array[1],
      lastname: user_array[2],
      age: user_array[3],
      password: user_array[4],
      email: user_array[5]
    }
  end
end
