# frozen_string_literal: true

class AddDateToSchedules < ActiveRecord::Migration[6.1]
  def change
    add_column :schedules, :date, :date
  end
end
