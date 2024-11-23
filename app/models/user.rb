class User < ApplicationRecord

  validates :nickname, presence: true
  validates :email, presence: true, uniqueness: true
end
