# User.where(email: 'manager@business.com', first_name: 'Bob', last_name: 'Jones', role: 'manager').first_or_create(password: 'password1', password_confirmation: 'password1')
# User.where(email: 'employee@business.com', first_name: 'Jack', last_name: 'Philips', role: 'employee').first_or_create(password: 'password2', password_confirmation: 'password2')
# 
# (1..100).each do |i|
  # Product.where(name: 'Item'+i.to_s, description: 'description'+i.to_s, count: 25%i).first_or_create
  # Product.find(i).update(price: ((17.to_f/(i+1).to_f)/3.to_f)*100.to_f)
# end
# Order.create(payment_total: Product.find(11).price, payment_type: "Credit Card", employee: "Bob Jones")
# OrderProduct.create(order_id: Order.last.id, product_id: 11, product_count: 1)
# 
# 
# 
# User.where(email: 'manager@business.com', first_name: 'Sample', last_name: 'Manager', role: 'manager').first_or_create(password: 'password1', password_confirmation: 'password1')
# User.where(email: 'employee@business.com', first_name: 'Sample', last_name: 'Employee', role: 'employee').first_or_create(password: 'password1', password_confirmation: 'password2')

# does not work with sqlite3
connection = ActiveRecord::Base.connection()
connection.execute("truncate table users; truncate table orders; truncate table products; truncate table order_products;")

# User.delete_all
# Order.delete_all
# Product.delete_all
# OrderProduct.delete_all

user_list = [
  [ "Scott", "McGregor", "smcgregor@business.com", "manager", "password1" ],
  [ "Jennifer", "Smith", "jsmith@business.com", "manager", "password1"  ],
  [ "Michael", "Parks", "mparks@business.com", "manager", "password1"  ],
  [ "Michael", "Markowkin", "mmarkowkin@business.com", "manager", "password1"  ],
  [ "Nasseh", "Tabrizi", "tabrizi@business.com", "manager", "password1"  ],
  [ "Mark", "Hills", "hills@business.com", "manager", "password1"  ]
]

user_list.each do |firstname, lastname, email, role, password|
  User.where(email: email, first_name: firstname, last_name: lastname, role: role).first_or_create(password: password, password_confirmation: password)
end

product_list = [
  [ "Shirt", "Black Short Sleeve Cotton", Random.rand(1..50), 10 ],
  [ "Shirt", "White Short Sleeve Cotton", Random.rand(1..50), 10 ],
  [ "Shirt", "Red Long Sleeve Cotton", Random.rand(1..50), 15 ],
  [ "Shirt", "Blue Long Sleeve Cotton", Random.rand(1..50), 15 ],
  [ "Pants", "Khaki Shorts", Random.rand(1..50), 20 ],
  [ "Pants", "Blue Jeans", Random.rand(1..50), 25 ],
  [ "Pants", "Black Jeans", Random.rand(1..50), 30 ],
  [ "Shoes", "White Sneakers", Random.rand(1..50), 60 ],
  [ "Shoes", "Brown Loafers", Random.rand(1..50), 85 ],
  [ "Hat", "Red Baseball Cap", Random.rand(1..50), 12 ],
  [ "Hat", "Brown Fedora", Random.rand(1..50), 12 ],
  [ "Jacket", "Gray WindBreaker", Random.rand(1..50), 30 ],
  [ "Coat", "Black Peacoat", Random.rand(1..50), 100 ],
  [ "Boots", "Brown Construction Boots", Random.rand(1..50), 80 ],
  [ "Scarf", "Black Silk", Random.rand(1..50), 8 ],
  [ "Watch", "Black Sports Watch", Random.rand(1..50), 75 ],
  [ "Watch", "Silver Automatic Diver Watch", Random.rand(1..50), 75 ],
  [ "Wallet", "Tan Leather", Random.rand(1..50), 40 ],
  [ "Sun Glasses", "Polarized Sunglasses", Random.rand(1..50), 25 ],
  [ "Bracelet", "14k Gold Tennis Bracelet", Random.rand(1..50), 150 ]
]

product_list.each do |item, description, count, price|
  Product.where(name: item+'-'+description, description: description, count: count, price: price).first_or_create
 end
 
 order_list = [
 [ Random.rand(Product.first.id..Product.last.id), "Credit Card", User.all.sample],
 [ Random.rand(Product.first.id..Product.last.id), "Credit Card", User.all.sample],
 [ Random.rand(Product.first.id..Product.last.id), "Debit Card", User.all.sample],
 [ Random.rand(Product.first.id..Product.last.id), "Cash", User.all.sample],
 [ Random.rand(Product.first.id..Product.last.id), "Cash", User.all.sample],
 [ Random.rand(Product.first.id..Product.last.id), "Cash", User.all.sample],
 [ Random.rand(Product.first.id..Product.last.id), "Credit Card", User.all.sample],
 [ Random.rand(Product.first.id..Product.last.id), "Debit Card", User.all.sample],
 [ Random.rand(Product.first.id..Product.last.id), "Debit Card", User.all.sample],
 [ Random.rand(Product.first.id..Product.last.id), "Cash", User.all.sample],
 [ Random.rand(Product.first.id..Product.last.id), "Credit Card", User.all.sample]
 
 ]

order_list.each do |id, payment, employee|
  Order.create(payment_total: Product.find(id).price, payment_type: payment, employee: employee.first_name+' '+ employee.last_name)
  OrderProduct.create(order_id: Order.last.id, product_id: id, product_count: Random.rand(1..10))
end
