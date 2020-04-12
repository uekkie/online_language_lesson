class CreateTeacherLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :teacher_languages do |t|
      t.references :teacher, null: false, foreign_key: true, index: false
      t.references :language, null: false, foreign_key: true
    end
    add_index :teacher_languages, [:teacher_id, :language_id], unique: true
  end
end
