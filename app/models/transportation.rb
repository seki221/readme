class Transportation < ApplicationRecord
  has_many :schedule_transportations, dependent: :destroy
  has_many :schedules, through: :schedule_transportations
end
