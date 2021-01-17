class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  # No need to destroy associations because of acts_as_paranoid (soft delete)
  # rubocop:disable Rails/HasManyOrHasOneDependent
  has_many :payment_sessions
  has_many :fulfilled_payments, -> { fulfilled },
           class_name: "PaymentSession",
           inverse_of: :user
  has_many :bought_items, through: :fulfilled_payments, source: :item
  # rubocop:enable Rails/HasManyOrHasOneDependent

  validates :first_name, :last_name, presence: true

  acts_as_paranoid

  def full_name
    "#{first_name} #{last_name}"
  end
end
