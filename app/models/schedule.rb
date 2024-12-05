class Schedule < ApplicationRecord
  belongs_to :user

  validates :start_at, presence: true
  validates :end_at, presence: true
  validate :end_after_start

  def self.ransackable_associations(auth_object = nil)
    %w[user]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[destination start_at end_at cost review transportation]
  end


  def end_after_start
    if end_at.present? && start_at.present? && end_at <= start_at
      errors.add(:end_at, 'は開始日時より後である必要があります')
    end
  end

end
