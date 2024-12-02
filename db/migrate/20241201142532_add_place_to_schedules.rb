class AddPlaceToSchedules < ActiveRecord::Migration[6.1]
  def change
    add_column :schedules, :place, :string
  end
end
