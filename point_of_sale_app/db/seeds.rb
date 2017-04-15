User.where(email: 'manager@business.com', password: 'password1', password_confirmation: 'password1', first_name: 'Bob', last_name: 'Jones', role: 'manager').first_or_create
User.where(email: 'employee@business.com', password: 'password2', password_confirmation: 'password2', first_name: 'Jack', last_name: 'Philips', role: 'employee').first_or_create
