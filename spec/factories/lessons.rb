FactoryBot.define do
  factory :lesson do
    start_date { DateTime.now }
    zoom_url { 'https://zoom.us/123456' }
  end
end
