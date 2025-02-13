# frozen_string_literal: true

class AddPlannerIdToSchedules < ActiveRecord::Migration[6.1]
  def change
    add_column :schedules, :planner_id, :bigint
    add_foreign_key :schedules, :planners, column: :planner_id
    add_index :schedules, :planner_id
  end
end
