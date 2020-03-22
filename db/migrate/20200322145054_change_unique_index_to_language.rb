class ChangeUniqueIndexToLanguage < ActiveRecord::Migration[6.0]
  def up
    remove_index :languages, :name
    add_index :languages, [:teacher_id, :name], unique: true
  end

  def down
    remove_index :languages, [:teacher_id, :name]
    add_index :languages, :name, unique: true
  end
end
