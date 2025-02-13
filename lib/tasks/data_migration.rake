# frozen_string_literal: true

namespace :data_migration do
  desc 'Migrate schedules to planners'
  task migrate_schedules_to_planners: :environment do
    Schedule.find_each do |schedule|
      # 該当するPlannerを作成または取得
      planner = Planner.find_or_create_by(date: schedule.start_at.to_date)

      # PlannerとScheduleを関連付け
      planner.schedules << schedule unless planner.schedules.include?(schedule)
    end
  end
end
