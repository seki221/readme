class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :schedule

  validates :user_id, uniqueness: { scope: :scheduled_id, message: "This schedule is already favorited." }
end
