FactoryBot.define do
  factory :reservation do
    user { nil }
    lesson { nil }
    date { "2020-03-08" }
    zoom_url { "MyString" }
  end
end
