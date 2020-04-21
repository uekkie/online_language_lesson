class AddRefTeacherIdToLanguage < ActiveRecord::Migration[6.0]
  def change
    add_reference :languages, :teacher, null: false, foreign_key: true
  end
end
