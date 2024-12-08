class Schedule < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :schedule_transportations, dependent: :destroy
  has_many :transportations, through: :schedule_transportations
  has_many :favorites, dependent: :destroy

  validates :start_at, presence: true
  validates :end_at, presence: true
  validate :end_after_start

  def self.ransackable_associations(auth_object = nil)
    %w[user]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[destination start_at end_at cost review transportations]
  end


  def end_after_start
    if end_at.present? && start_at.present? && end_at <= start_at
      errors.add(:end_at, 'は開始日時より後である必要があります')
    end
  end

end
