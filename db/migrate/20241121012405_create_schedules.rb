class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.string :destination
      t.datetime :start_at
      t.datetime :end_at
      t.integer :cost
      t.text :review
      t.string :transportation
      t.integer :position

      t.timestamps
    end
  end
end
