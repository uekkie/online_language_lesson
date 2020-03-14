class CreateTicketBalances < ActiveRecord::Migration[6.0]
  def change
    create_table :ticket_balances do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :amount, null: false, default: 0

      t.timestamps
    end
  end
end
