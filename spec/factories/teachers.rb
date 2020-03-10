FactoryBot.define do
  factory :teacher do
    sequence(:email){|n| "teacher#{n}@example.com"}
    password {"password"}
    password_confirmation {"password"}
  end
end
