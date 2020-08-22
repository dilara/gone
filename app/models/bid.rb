# frozen_string_literal: true

class Bid < ApplicationRecord
  # Relations
  belongs_to :bidder, class_name: 'User', foreign_key: :bidder_id
  belongs_to :auction

  # Validations
  validates :offer, presence: true, format:  { with: /\A\d+(?:\.\d{0,2})?\z/ },
                    numericality: { greater_than: 0, less_than: 1_000_000 }
  validates :made_at, presence: true
end
