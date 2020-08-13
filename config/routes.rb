# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :user, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
end
