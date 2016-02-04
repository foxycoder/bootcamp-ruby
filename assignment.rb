# Start with asking my name
puts "What is your name?"
name = gets.chomp

# Then my age
puts "What is your age?"
age = gets.chomp.to_i

# Then my gender
def ask_gender
  puts "What is your gender? (m/f)"
  gender = gets.chomp.downcase

  if gender == "m" || gender == "f"
    return gender
  else
    puts "That is not a valid gender, please try again!"
    ask_gender
  end
end

# Greet me with a proper Mr. or Ms. or...?
def salute(name, gender)
  if gender == "m"
    salutation = "Mr."
  else
    salutation = "Ms."
  end

  salutation = "#{salutation} #{name}"
end

puts "Hi, #{salute(name, ask_gender)}! You are #{age} years old."

# Tell me when I will be 100 years old (which year)
years_left = 100 - age

puts "You will turn 100 years old in #{Time.now.year + years_left}. That's in #{years_left} years."
