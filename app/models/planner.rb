# frozen_string_literal: true

class Planner < ApplicationRecord
  has_many :schedules, dependent: :destroy
  belongs_to :user
end
