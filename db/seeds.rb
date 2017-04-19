User.where(email: 'manager@business.com', first_name: 'Bob', last_name: 'Jones', role: 'manager').first_or_create(password: 'password1', password_confirmation: 'password1')
User.where(email: 'employee@business.com', first_name: 'Jack', last_name: 'Philips', role: 'employee').first_or_create(password: 'password2', password_confirmation: 'password2')

(1..100).each do |i|
  Product.where(name: 'Item'+i.to_s, description: 'description'+i.to_s, count: 25%i).first_or_create
  Product.find(i).update(price: ((17.to_f/(i+1).to_f)/3.to_f)*100.to_f)
end
