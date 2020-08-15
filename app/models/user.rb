# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Callbacks
  before_validation :set_random_password, on: :create, if: proc { |user| !user.customer? }

  # Enums
  enum status: { active: 0, inactive: 1 }
  enum role: { customer: 0, admin: 1 }

  # Validations
  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :role, inclusion: { in: roles.keys }
  validates :status, inclusion: { in: statuses.keys }

  private

  def set_random_password
    self.password = Devise.friendly_token.first(8)
  end
end
