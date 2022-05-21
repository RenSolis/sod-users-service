users = [
  { name: 'Renzo', email: 'renzo@test.com', password: 'password123$', bio: 'rubyist' }
]

users.each do |user|
  User.create(user)
end
