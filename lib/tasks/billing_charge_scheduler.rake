desc "定期決済の実行"
task billing_charge:  :environment do
  Subscription.available.billable.each do |subscription|
    plan = Plan.find(subscription.plan_id)
    subscription.user.subscribe(plan)
  end
end
