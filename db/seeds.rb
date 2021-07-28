puts "Clearing old data"
Coffee.destroy_all
Customer.destroy_all
Order.destroy_all

puts "Seeding customers 🕺..."
15.times do
    Customer.create(name: Faker::Name.name)
end

puts "Seeding coffee ☕..." 
15.times do 
    Coffee.create(title: Faker::Coffee.blend_name)
end

puts "Seeding orders 💰..."
15.times do 
    Order.create(price: rand(2..6), customer_id: Customer.ids.sample, coffee_id: Coffee.ids.sample)
end

puts "Done! ✅"