class CreateTimeTables < ActiveRecord::Migration[6.0]
  def change
    create_table :time_tables do |t|
      t.time :start_time, null:false, default: ""

      t.timestamps
    end
  end
end
