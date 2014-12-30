class HardwareStore
  attr_reader :address
  attr_reader :name
  attr_reader :inventory

  def initialize(name, address, inventory = {})
    @name = name
    @address = address
    @inventory = inventory
  end

  def sell_to(customer, hardware)
    hardware.each do |item, cost|
      customer.pay(cost)
      @inventory.delete(item)
    end
    print_receipt(hardware)
  end

  def print_receipt(hardware)
    receipt_string = "#{@name}\n"
    receipt_string += "#{@address}\n"
    total = hardware.inject(0) do |total_cost, (title, cost)|
      receipt_string += "#{title} \t\t #{cost}\n"
      total_cost += cost
    end
    receipt_string += "--------------------------\nTotal Cost: #{total}"
  end
end
