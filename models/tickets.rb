require_relative("../db/sql_runner")
require_relative("customers")
require_relative("films")

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id 

  def initialize(tickets)
    @id = tickets['id'].to_i
    @customer_id = tickets['user_id'].to_i
    @film_id = tickets['film_id'].to_i
  end

  def customer()
    sql = "SELECT * FROM customers WHERE id = #{@customer_id}"
    customer = SqlRunner.run(sql).first
    return Customer.new(user)
  end  

  def film()
    sql = "SELECT * FROM films WHERE id = #{@film_id}"
    film = SqlRunner.run(sql).first
    return Film.new(location)
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id)
           VALUES ('#{ @customer_id }', '#{ @film_id }') RETURNING id"
    ticket = SqlRunner.run( sql ).first
    @id = ticket['id'].to_i
  end

  def delete()
      sql = "DELETE FROM tickets WHERE id = #{@id}"
      SqlRunner.run(sql)
  end


  def update()
      sql = "UPDATE tickets SET (film_id, customer_id, price_id) = (#{@film_id},#{@customer_id},#{@price_id}) WHERE id = #{@id}"
      SqlRunner.run(sql)
    end

  def self.all()
    sql = "SELECT * FROM tickets"
    return self.get_many(sql)
  end

  def self.delete_all()
   sql = "DELETE FROM tickets"
   SqlRunner.run(sql)
  end

  def self.get_many(sql)
    tickets = SqlRunner.run(sql)
    result = tickets.map { |ticket| Ticket.new(ticket) }
    return result
  end
end