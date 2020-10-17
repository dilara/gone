# frozen_string_literal: true

class Brand < ApplicationRecord
  # Relations
  has_many :auctions, dependent: :nullify

  # Enums
  enum status: { active: 0, inactive: 1 }

  # Validations
  validates :status, inclusion: { in: statuses.keys }
  validates :name, presence: true, length: { maximum: 255 }

  # Scopes
  default_scope { order(:name) }
end
