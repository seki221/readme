class CreatePlannersSchedulesJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_table :planners_schedules do |t|
      t.bigint :planner_id, null: false
      t.bigint :schedule_id, null: false
      t.string :note # 将来使うかもしれないカラム
      t.timestamps
    end

    add_index :planners_schedules, [:planner_id, :schedule_id], unique: true
    add_foreign_key :planners_schedules, :planners
    add_foreign_key :planners_schedules, :schedules
  end
end
