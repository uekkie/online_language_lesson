class Billing < ApplicationRecord
  belongs_to :user

  scope :recent, -> {
    order(created_at: :desc)
  }

  def plan
    Plan.find(plan_id)
  end

end
