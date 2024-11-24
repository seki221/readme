class Schedule < ApplicationRecord
  belongs_to :user
  validates :destination, presence: true
end
