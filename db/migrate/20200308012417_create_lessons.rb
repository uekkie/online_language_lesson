class CreateLessons < ActiveRecord::Migration[6.0]
  def change
    create_table :lessons do |t|
      t.references :teacher, null: false, foreign_key: true
      t.references :language, null: false, foreign_key: true
      t.references :time_table, null: false, foreign_key: true

      t.timestamps
    end
  end
end
