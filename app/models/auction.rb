# frozen_string_literal: true

class Auction < ApplicationRecord
  # Relations
  belongs_to :brand
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  has_many :bids, dependent: :destroy
  has_one_attached :cover, dependent: :destroy
  has_many_attached :images, dependent: :destroy

  # Enums
  enum status: { available: 0, sold: 1, completed: 2 }

  # Validations
  validates :status, inclusion: { in: statuses.keys }
  validates :name, presence: true, length: { maximum: 255 }
  validates :description, presence: true
  validates :base_price, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ },
                         numericality: { greater_than: 0, less_than: 1_000_000 }
  validates :starts_at, presence: true
  validates :expires_at, presence: true
  validates_with AuctionValidator

  # Scopes
  default_scope { order(created_at: :desc) }
  scope :inactive, -> { where('starts_at > ?', now) }
  scope :active, -> { where('starts_at < ? and expires_at > ?', now, now) }
  scope :expired, -> { where('expires_at < ?', now) }
  scope :price_under, ->(max) { where('base_price <= ?', max) if max.presence }
  scope :price_above, ->(min) { where('base_price >= ?', min) if min.presence }

  def highest_bid
    bids.order(offer: :desc).first
  end

  def inactive?
    starts_at > Time.zone.now
  end

  def expired?
    expires_at < Time.zone.now
  end

  def active?
    !inactive? && !expired?
  end

  def self.now
    @now ||= Time.zone.now
  end
end
