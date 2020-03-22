FactoryBot.define do
  factory :language do
    name { Faker::Address.country }
  end
end
