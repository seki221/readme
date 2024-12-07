class CreateScheduleTransportations < ActiveRecord::Migration[6.1]
  def change
    create_table :schedule_transportations do |t|
      t.references :schedule, null: false, foreign_key: true
      t.references :transportation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
