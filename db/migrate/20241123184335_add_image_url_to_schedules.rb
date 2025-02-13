# frozen_string_literal: true

class AddImageUrlToSchedules < ActiveRecord::Migration[6.1]
  def change
    add_column :schedules, :image_url, :string
  end
end
