class ChangeNameAvatarToTeacher < ActiveRecord::Migration[6.0]
  def change
    rename_column :teachers, :avatar_url, :avatar
  end
end
