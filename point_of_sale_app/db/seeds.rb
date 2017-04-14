User.first_or_create(email: 'manager@business.com', password: 'password1', password_confirmation: 'password1')
User.first_or_create(email: 'employee@business.com', password: 'password2', password_confirmation: 'password2')
