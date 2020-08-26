# frozen_string_literal: true

class AuctionValidator < ActiveModel::Validator
  def validate(record)
    now = Time.zone.now
    record.errors.add(:starts_at, "can't be in the past") if record.expires_at < now
    record.errors.add(:expires_at, "can't be in the past") if record.starts_at < now
    return unless record.expires_at <= record.starts_at

    record.errors.add(:expires_at, "can't be earlier than starts at")
  end
end
