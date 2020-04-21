FactoryBot.define do
  factory :teacher do
    name {"鈴木"}
    sequence(:email){|n| "teacher#{n}@example.com"}
    password {"password"}
    password_confirmation {"password"}
  end

  factory :admin, class: "Teacher" do
    name {"管理者"}
    admin { true }
    sequence(:email){|n| "admin#{n}@example.com"}
    password {"password"}
    password_confirmation {"password"}
  end
end
