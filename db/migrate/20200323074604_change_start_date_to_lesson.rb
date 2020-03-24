class ChangeStartDateToLesson < ActiveRecord::Migration[6.0]
  def up
    remove_column :lessons, :start_date
    add_column :lessons, :date, :date, null: false
    add_column :lessons, :hour, :integer, null: false, default: 7
  end

  def down
    remove_column :lessons, :date
    remove_column :lessons, :hour
    add_column :lessons, :start_date, null: false
  end
end
