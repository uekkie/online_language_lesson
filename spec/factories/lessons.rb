FactoryBot.define do
  factory :lesson do
    teacher { create(:teacher) }
    language { create(:language, teacher: teacher) }
    date { Date.current }
    hour { 7 }
    zoom_url { 'https://zoom.us/123456' }
  end
end
