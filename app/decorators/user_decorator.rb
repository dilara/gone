# frozen_string_literal: true

class UserDecorator < SimpleDelegator
  def full_name
    "#{first_name} #{last_name}"
  end

  def avatar
    super.attached? ? super : ActionController::Base.helpers.image_url('avatar.png')
  end
end
