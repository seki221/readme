class Schedule < ApplicationRecord
  belongs_to :user
  validates :destination, presence: true

  def self.ransackable_associations(auth_object = nil)
    %w[user]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[destination start_at end_at cost review transportation]
  end
end
