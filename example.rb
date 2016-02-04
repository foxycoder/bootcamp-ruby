puts "Type your name.."
name = gets.chomp

puts "Type you age"
age = gets.chomp.to_i

def ask_sex
  puts "Are you male or female (m/f)?"
  sex = gets.chomp
  if sex == "m" || sex == "M"
    return "m"
  elsif sex == "f" || sex == "F"
    return "f"
  else
    puts "That is not a valid input!"
    return ask_sex
  end
end

sex = ask_sex

if sex == "m" && age >= 18
  puts "Goodmorning Mr. #{name}!"
elsif sex == "v" && age >= 18
  puts "Goodmorning Mrs. #{name}!"
else
  puts "Goodmorning #{name}"
end

years_left = 100 - age
year = 2016 + years_left

puts "You will be 100 years old in: #{year}"
