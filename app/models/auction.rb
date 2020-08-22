# frozen_string_literal: true

class Auction < ApplicationRecord
  # Relations
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  has_one_attached :cover, dependent: :destroy

  # Enums
  enum status: { active: 0, inactive: 1 }

  # Validations
  validates :status, inclusion: { in: statuses.keys }
  validates :name, presence: true, length: { maximum: 255 }
  validates :description, presence: true
  validates :base_price, presence: true, format:  { with: /\A\d+(?:\.\d{0,2})?\z/ },
                         numericality: { greater_than: 0, less_than: 1_000_000 }
  validates :starts_at, presence: true
  validates :expires_at, presence: true
end