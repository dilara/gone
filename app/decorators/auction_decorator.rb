# frozen_string_literal: true

class AuctionDecorator < SimpleDelegator
  def cover_with_ribbon
    return cover_tag if open?

    h.content_tag :div, class: 'position-relative' do
      h.concat cover_tag
      h.concat h.content_tag :div,
                             h.content_tag(:div, status, class: 'ribbon bg-secondary'),
                             class: 'ribbon-wrapper ribbon-lg'
    end
  end

  private

  def cover_tag
    h.image_tag Rails.application.routes.url_helpers.rails_blob_path(cover, only_path: true), class: 'product-image'
  end

  def h
    ActionController::Base.helpers
  end
end
