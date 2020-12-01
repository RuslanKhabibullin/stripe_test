class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  validates :first_name, :last_name, presence: true
end
