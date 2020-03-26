class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.references :user, null: false, foreign_key: true, index: false
      t.references :lesson, null: false, foreign_key: true
      t.text :content, null: false, default: ""

      t.timestamps
    end
    add_index :reports, [:user_id, :lesson_id], unique: true
  end
end
