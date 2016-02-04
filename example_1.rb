puts "Typ je naam in a.u.b.."
naam = gets.chomp
puts "Goedemorgen #{naam}"

puts "Vul je leeftijd in"
leeftijd = gets.chomp.to_i

jaren_over = 100 - leeftijd
jaartal = 2015 + jaren_over
puts "U wordt 100 in het jaar: #{jaartal}"
