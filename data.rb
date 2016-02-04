products = {
  A: {
    name: "Apple",
    price: 0.99
  },
  B: {
    name: "Banana",
    price: 1.15
  },
  C: {
    name: "Lemon",
    price: 0.89
  },
  D: {
    name: "Pineapple",
    price: 4.98
  }
}

ordered = []

def make_choice(products, ordered)
  products.each do |id, product|
    puts "#{id}) #{product[:name]}"
  end
  puts "Choose one: [#{products.keys.join(", ")}]"
  choice = gets.chomp.upcase.to_sym

  puts "You chose: #{products[choice][:name]}"

  ordered << products[choice]

  puts "So far you ordered:"

  ordered.each do |product|
    puts "• #{product[:name]}"
  end

  puts ""

  make_choice(products, ordered)
end

make_choice(products, ordered)
