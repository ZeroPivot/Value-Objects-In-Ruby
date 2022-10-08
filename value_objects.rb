# A Study of "Value Objects" in Ruby 3.0 with RBS for static typing
#
# Ruby Code by ZeroPivot
#
# Studied from JavaScript article @ plainenglish.io (by Nayab Siddiqui);
# * URL: https://javascript.plainenglish.io/why-you-should-stop-representing-age-as-a-number-in-your-code-ea1026a86bc8

# A Value Object Class named Age
# Returns a new Age object on the addition of time (y/m/d)
# Instance objects are treated in an immutable fashion
class Age 
  # read access to instance variables
  attr_reader :years, :months, :days
  
  def initialize(years: Integer, months: Integer, days: Integer)
    if years <= 0 || months <= 0 || days <= 0
      # Throw a basic error just for getting a check (or 3) wrong
      throw StandardError
    end
    @years, @months, @days = years, months, days
  end

  def add_days(days: Integer)
    Age.new(years: @years, months: @months, days: @days + days)
  end

  def add_months(months: Integer)
    Age.new(years: @years, months: @months + months, days: @days)
  end

  def add_years(years: Integer)
    Age.new(years: @years + years, months: @months, days: @days)
  end

  def print_age
    "Y:#{@years}-M:#{@months}-D:#{@days}"
  end

  def age_in_years?
    @years + @months / 12 + @days / 365
  end

  def age_in_months?
    @years * 12 + @months / 12 + @days / 30 
  end 

  def age_in_days?
    @years * 365 + @months * 30 + @days
  end

  # Compare 2 Ages together
  def ==(other)
    throw StandardError unless other.is_a? Age
    other.age_in_days? == self.age_in_days?   
  end

end

# Testing
age = Age.new(years: 42, months: 3, days: 1)
puts 'Initial Age'
puts age.print_age


age = age.add_years(years: 1)
age = age.add_months(months: 3)
age = age.add_days(days: 23)

puts 'Ending Age'
puts age.print_age

# comparing ages (just uses days)
other_age = Age.new(years: 43, months: 6, days: 38)
puts "age == other_age: #{age == other_age}" #=> evaluates to false

# lol
other_other_age = Age.new(years: 42, months: 3, days: 1)
other_other_age = other_other_age.add_years(years: 1)
other_other_age = other_other_age.add_months(months: 3)
other_other_age = other_other_age.add_days(days: 23)
puts "age == other_other_age: #{age == other_other_age}" #=> evaluates to true

# Other:
# (Throws StandardError)
# age2 = age.add_years(years: "lol") 
# using some basic static typing in ruby 3.0, you can catch errors in variable arguments, etc
