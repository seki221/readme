class User < ApplicationRecord
  has_many :trips

  validates :nickname, presence: true
  validates :email, presence: true, uniqueness: true
end
