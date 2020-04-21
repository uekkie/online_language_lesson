FactoryBot.define do
  factory :report do
    user { nil }
    lesson { nil }
    content { "MyText" }
  end
end
