class AddUniqueIndexToAttendances < ActiveRecord::Migration[7.1]
  def change
    add_index :attendances, [:user_id, :event_id], unique: true
  end
end
