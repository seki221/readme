class Schedule < ApplicationRecord
  belongs_to :user
  validates :destination, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true
  validate :end_after_start

  def self.ransackable_associations(auth_object = nil)
    %w[user]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[destination start_at end_at cost review transportation]
  end

  class Schedule < ApplicationRecord
    validates :start_time, presence: true, format: { with: /\A\d{2}:\d{2}\z/, message: "はHH:MM形式で入力してください" }
  end

end
