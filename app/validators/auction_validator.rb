# frozen_string_literal: true

class AuctionValidator < ActiveModel::Validator
  def validate(record)
    @record = record
    validate_dates
    validate_cover_presence
  end

  private

  def validate_dates
    now = Time.zone.now
    @record.errors.add(:starts_at, "can't be in the past") if @record.starts_at < now
    @record.errors.add(:expires_at, "can't be in the past") if @record.expires_at < now
    @record.errors.add(:expires_at, "can't be earlier than starts at") if @record.expires_at <= @record.starts_at
  end

  def validate_cover_presence
    return @record.errors.add(:cover, 'no file added') unless @record.cover.attached?
    return if @record.cover.content_type.in?(%('image/jpeg image/png'))

    @record.errors.add(:cover, 'needs to be a jpeg or png')
  end
end
