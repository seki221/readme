# frozen_string_literal: true

class AddUserIdToSchedules < ActiveRecord::Migration[6.1]
  def change
    add_reference :schedules, :user, null: false, foreign_key: true
  end
end
