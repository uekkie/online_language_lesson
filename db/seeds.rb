if Language.count == 0
  Language.create(name: '英語')
  Language.create(name: 'スペイン語')
  Language.create(name: 'ヒンドゥー語')
  Language.create(name: 'フランス語')
end

if Teacher.where(admin: true).blank?
  Teacher.create(name: 'admin', email: 'admin@example.com', password: 'aaaaaa', password_confirmation: 'aaaaaa', admin: true)
end
