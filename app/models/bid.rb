# frozen_string_literal: true

class Bid < ApplicationRecord
  # Callbacks
  before_validation :set_made_at, on: :create

  # Relations
  belongs_to :bidder, class_name: 'User', foreign_key: :bidder_id
  belongs_to :auction

  # Validations
  validates :offer, presence: true, format:  { with: /\A\d+(?:\.\d{0,2})?\z/ },
                    numericality: { greater_than: 0, less_than: 1_000_000 }
  validates :made_at, presence: true
  validates_with BidValidator

  private

  def set_made_at
    self.made_at = Time.zone.now
  end
end
