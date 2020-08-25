# frozen_string_literal: true

class BidsController < ApplicationController
  before_action :set_auction

  def create
    @bid = @auction.bids.create(bid_params.merge(bidder_id: current_user.id))
    respond_to :js
  end

  private

  def set_auction
    @auction = Auction.find(params[:auction_id])
  end

  def bid_params
    params.require(:bid).permit(:offer)
  end
end
