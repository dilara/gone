# frozen_string_literal: true

class BidValidator < ActiveModel::Validator
  def validate(record)
    @record = record
    @auction = record.auction

    return record.errors.add(:base, 'You cannot bid on your own auction') if @auction.owner_id == record.bidder_id
    return record.errors.add(:base, 'The auction is not open to bid') unless @auction.available?
    return record.errors.add(:base, 'The auction is expired') if @auction.expired?

    validate_offer
  end

  def validate_offer
    if (highest_bid = @auction.highest_bid).presence
      @record.errors.add(:offer, 'must be higher than the highest bid') if @record.offer <= highest_bid.offer
    elsif @record.offer <= @auction.base_price
      @record.errors.add(:offer, 'must be higher than the base price')
    end
  end
end
