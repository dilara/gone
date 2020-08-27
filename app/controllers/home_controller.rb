# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @auctions = Auction.all.with_attached_cover if current_user.member?
  end
end
