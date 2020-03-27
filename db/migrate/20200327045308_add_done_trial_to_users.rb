class AddDoneTrialToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :done_trial, :boolean, null: false, default: false
  end
end
