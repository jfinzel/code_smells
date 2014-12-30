class GroceryStore
  attr_reader :address
  attr_reader :name
  attr_reader :stock

  def initialize(name, address, stock = {})
    @name = name
    @address = address
    @stock = stock
  end

  def has_item(item)
    @stock.has_key?(item)
  end

  def sell_to(customer, groceries)
    groceries.each do |item, cost|
      customer.pay(cost)
      @stock.delete(item)
    end
    print_receipt(groceries)
  end

  def print_receipt(groceries)
    receipt_string = "#{@name}\n"
    receipt_string += "#{@address}\n"
    total = groceries.inject(0) do |total_cost, (title, cost)|
      receipt_string += "#{title} \t\t #{cost}\n"
      total_cost += cost
    end
    receipt_string += "--------------------------\nTotal Cost: #{total}"
  end

end
