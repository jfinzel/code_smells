class Customer
  attr_reader :name
  attr_reader :date_of_birth
  attr_reader :address

  def initialize(name, date_of_birth, address)
    @name = name
    @date_of_birth = date_of_birth
    @rentals = []
    @address = address
  end

  def summary
    "#{@name}, #{@address.house} #{@address.street}, #{@address.city}, #{@address.state} #{@address.zipcode}"
  end

  def age_in_years(today = Date.today)
    date_of_birth = Date.strptime(date_of_birth, "%Y-%m-%d")
    age_year = today.year - date_of_birth.year
    age_month = today.month - date_of_birth.month
    age_year - negative_month_difference(age_month)
  end

  private
  def negative_month_difference(months)
    months < 0 ? 1 : 0
  end

end
