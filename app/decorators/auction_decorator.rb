# frozen_string_literal: true

class AuctionDecorator < SimpleDelegator
  def about_to_start?
    starts_in.positive? && starts_in < 15.minutes
  end

  def about_to_expire?
    expires_in.positive? && expires_in < 15.minutes
  end

  def cover_with_ribbon
    return cover_tag if active?

    h.content_tag :div, class: 'position-relative' do
      h.concat cover_tag
      h.concat h.content_tag :div,
                             h.content_tag(:div, ribbon_text, class: 'ribbon bg-secondary'),
                             class: 'ribbon-wrapper ribbon-lg'
    end
  end

  def expires_in
    @expires_in ||= expires_at - now
  end

  def starts_in
    @starts_in ||= starts_at - now
  end

  def ribbon_text
    return unless expired?
    return 'inactive' if inactive?

    available? ? 'expired' : 'sold'
  end

  private

  def cover_tag
    h.image_tag Rails.application.routes.url_helpers.rails_blob_path(cover, only_path: true), class: 'product-image'
  end

  def h
    ActionController::Base.helpers
  end

  def now
    @now ||= Time.zone.now
  end
end
