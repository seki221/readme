class AddStartAndEndDateToPlannerAndSchedule < ActiveRecord::Migration[6.1]
  def change
    # Plannerテーブルにstart_dateとend_dateを追加
    add_column :planners, :start_date, :date
    add_column :planners, :end_date, :date
    add_column :planners, :title, :string

    # Scheduleテーブルにstart_dateとend_date,titleを追加
    add_column :schedules, :start_date, :datetime
    add_column :schedules, :end_date, :datetime
    add_column :schedules, :title, :string

    # Scheduleテーブルからdestinationカラム等を削除
    remove_column :schedules, :destination, :date
    remove_column :schedules, :start_at, :datetime
    remove_column :schedules, :end_at, :datetime
    # Plannerテーブルからdateカラムを削除
    remove_column :planners, :date, :date
  end
end
