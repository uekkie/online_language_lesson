FactoryBot.define do
  factory :lesson_feedback do
    lesson { nil }
    user { nil }
    content { "MyText" }
  end
end
