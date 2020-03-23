if Teacher.count == 0
  Teacher.create(name: '鈴木', email: 'suzuki@example.com', password: 'aaaaaa', password_confirmation: 'aaaaaa')
end

if User.count == 0
  User.create(name: '山田', email: 'yamada@example.com', password: 'aaaaaa', password_confirmation: 'aaaaaa')
end

if Teacher.where(admin: true).blank?
  Teacher.create(name: 'admin', email: 'admin@example.com', password: 'aaaaaa', password_confirmation: 'aaaaaa', admin: true)
end

