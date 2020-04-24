FactoryBot.define do
  factory :subscription do
    user { nil }
    plan { nil }
    suspend { false }
    start_at { "2020-04-25 07:59:52" }
  end
end
