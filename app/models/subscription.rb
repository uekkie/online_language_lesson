class Subscription < ApplicationRecord
  belongs_to :user

  def next_billing_date
    start_at.since(1.month)
  end

  def plan
    Plan.find(plan_id)
  end

  def suspend_status
    suspend? ? "休止中" : "自動継続中"
  end
end
