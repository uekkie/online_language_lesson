class Billing < ApplicationRecord
  belongs_to :user

  def plan
    Plan.find(plan_id)
  end
end
