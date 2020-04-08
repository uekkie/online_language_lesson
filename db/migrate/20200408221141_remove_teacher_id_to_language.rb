class RemoveTeacherIdToLanguage < ActiveRecord::Migration[6.0]
  def up
    remove_index :languages,  ["teacher_id", "name"]
    remove_index :languages, ["teacher_id"]
    remove_column :languages, :teacher_id
  end

  def down
    add_column  :languages, :teacher_id, :bigint
    add_index :languages,  ["teacher_id", "name"], name: "index_languages_on_teacher_id_and_name", unique: true
    add_index :languages, ["teacher_id"], name: "index_languages_on_teacher_id"
  end

end
