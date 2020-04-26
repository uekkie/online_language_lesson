class Subscription < ApplicationRecord
  belongs_to :user

  scope :available, -> {
    where(suspend: false)
  }
  scope :billable, -> {
    where("start_at < ?", 1.month.ago)
  }
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
