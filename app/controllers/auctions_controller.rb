# frozen_string_literal: true

class AuctionsController < ApplicationController
  before_action :set_auction, only: %i[show edit update destroy]

  def index
    @auctions = Auction.all
  end

  def show; end

  def new
    @auction = Auction.new
  end

  def edit; end

  def create
    @auction = Auction.new(auction_params.merge(owner: current_user))

    if @auction.save
      redirect_to @auction, notice: 'Auction was successfully created.'
    else
      render :new
    end
  end

  def update
    if @auction.update(auction_params)
      redirect_to @auction, notice: 'Auction was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @auction.destroy
      redirect_to auctions_url, notice: 'Auction was successfully destroyed.'
    else
      redirect_to @auction, notice: 'Auction was not destroyed.'
    end
  end

  private

  def set_auction
    @auction = Auction.find(params[:id])
  end

  def auction_params
    params.require(:auction).permit(:name, :description, :base_price, :starts_at, :expires_at, :cover)
  end
end
