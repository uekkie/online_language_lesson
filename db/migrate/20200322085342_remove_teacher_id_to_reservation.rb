class RemoveTeacherIdToReservation < ActiveRecord::Migration[6.0]
  def change
    remove_column :reservations, :teacher_id
  end
end
