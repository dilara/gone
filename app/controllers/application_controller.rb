# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  layout :layout_by_authority

  def current_user
    UserDecorator.new(super) unless super.nil?
  end

  protected

  def layout_by_authority
    return 'guest' if devise_controller? && (resource_name == :user) && %w[new create].include?(action_name)

    return 'authority' unless current_user.member?

    'application'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name username])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[avatar first_name last_name])
  end
end
