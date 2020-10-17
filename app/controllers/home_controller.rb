# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    if current_user.member?
      @brands = Brand.active.limit(6)
      @auctions = Auction.active.with_attached_cover
    end

    render current_user.member? ? 'member' : 'authority'
  end
end
