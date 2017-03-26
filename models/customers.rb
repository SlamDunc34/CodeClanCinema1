require_relative("../db/sql_runner")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(customers)
    @id = customers['id'].to_i
    @name = customers['name']
  end

  def films()
    sql = "SELECT films.* from films 
           INNER JOIN tickets ON tickets.film_id = films.id 
           WHERE tickets.customer_id = #{@id}"
    return Film.get_many(sql)
  end

  def save()
    sql = "INSERT INTO customers (name) VALUES ('#{ @name }') RETURNING id"
    user = SqlRunner.run( sql ).first
    @id = customer['id'].to_i
  end

  def update()
      sql = "UPDATE customers SET (name, funds) = ('#{@name}', #{@funds}) WHERE id = #{@id}"
      SqlRunner.run(sql)
  end

  def delete()
      sql = "DELETE FROM customers WHERE id = #{@id}"
      SqlRunner.run(sql)
    end

  def self.all()
    sql = "SELECT * FROM customers"
    return self.get_many(sql)
  end

  def self.delete_all()
   sql = "DELETE FROM customers"
   SqlRunner.run(sql)
  end

  def self.get_many(sql)
    customers = SqlRunner.run(sql)
    result = customers.map { |customer| Customer.new( customer ) }
    return result
  end
end