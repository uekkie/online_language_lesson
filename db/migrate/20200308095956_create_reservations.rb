class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :lesson, null: false, foreign_key: true
      t.date :date, null: false
      t.string :zoom_url, null:false, default: ""

      t.timestamps
    end
  end
end
