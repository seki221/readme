class AddScheduleIdToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :schedule_id, :integer
    add_index :reviews, :schedule_id
  end
end
