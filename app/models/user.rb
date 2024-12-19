class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true, length: { minimum: 2 }

  has_many :schedules, dependent: :destroy
  has_many :planner, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_schedules, through: :favorites, source: :schedule

  def own?(schedule)
    self.id == schedule.user_id
  end

  def self.ransackable_associations(auth_object = nil)
    %w[user]
  end
end
