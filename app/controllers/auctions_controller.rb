# frozen_string_literal: true

class AuctionsController < ApplicationController
  before_action :set_auction, only: %i[show edit update destroy edit_images update_images]

  def index
    @auctions = Auction.all
  end

  def show
    @auction = AuctionDecorator.new(@auction)
  end

  def new
    @auction = Auction.new
  end

  def edit; end

  def create
    @auction = Auction.new(auction_params.merge(owner_id: current_user.id))

    if @auction.save
      redirect_to edit_images_auction_path(@auction), notice: 'Auction was successfully created.'
    else
      render :new
    end
  end

  def edit_images; end

  def update_images
    if @auction.update(images_params)
      redirect_to @auction, notice: 'Images was successfully updated.'
    else
      render :edit_images
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

  def images_params
    params.require(:auction).permit(images: [])
  end
end
