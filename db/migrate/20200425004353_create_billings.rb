class CreateBillings < ActiveRecord::Migration[6.0]
  def change
    create_table :billings do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :plan_id, null:false

      t.timestamps
    end
  end
end
