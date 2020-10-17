# frozen_string_literal: true

class AuctionValidator < ActiveModel::Validator
  def validate(record)
    @record = record
    @record.errors.add(:expires_at, "can't be earlier than starts at") if @record.expires_at <= @record.starts_at
    validate_cover_presence
  end

  private

  def validate_cover_presence
    return @record.errors.add(:cover, 'no file added') unless @record.cover.attached?
    return if @record.cover.content_type.in?(%('image/jpeg image/png'))

    @record.errors.add(:cover, 'needs to be a jpeg or png')
  end
end
