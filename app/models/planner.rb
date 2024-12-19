class Planner < ApplicationRecord
  has_and_belongs_to_many :schedules
  belongs_to :user

  validates :user, presence: true
end
