class AddAddressToSchedules < ActiveRecord::Migration[6.1]
  def change
    add_column :schedules, :address, :text
  end
end
