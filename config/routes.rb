# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "callbacks" }
  root to: "home#index"

  namespace :admin do
    get "", to: "home#index"
    resources :users, only: %i[index show destroy]
  end
end
