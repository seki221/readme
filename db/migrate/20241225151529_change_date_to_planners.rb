# frozen_string_literal: true

class ChangeDateToPlanners < ActiveRecord::Migration[6.1]
  def change
    change_column :planners, :start_date, :datetime
    change_column :planners, :end_date, :datetime
  end
end
