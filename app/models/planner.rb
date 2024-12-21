class Planner < ApplicationRecord
  has_many :schedules, dependent: :destroy
  belongs_to :user

  validates :user, presence: true
end
