class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :plan_id, null: false
      t.boolean :suspend, null:false, default:false
      t.datetime :start_at

      t.timestamps
    end
  end
end
