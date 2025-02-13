# frozen_string_literal: true

class AddGuidToSchedules < ActiveRecord::Migration[6.1]
  def change
    add_column :schedules, :guaid, :text
  end
end
