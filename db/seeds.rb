# db/seeds.rb

User.all.destroy_all
User.create!(email:"veebraids.toronto@gmail.com",password:"admin123",password_confirmation:"admin123")