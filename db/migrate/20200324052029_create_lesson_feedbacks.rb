class CreateLessonFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :lesson_feedbacks do |t|
      t.references :lesson, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :content, null: false, defalt: ""

      t.timestamps
    end
    add_index :lesson_feedbacks, [:lesson_id, :user_id], unique: true
  end
end
