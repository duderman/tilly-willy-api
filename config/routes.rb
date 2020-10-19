# frozen_string_literal: true

Rails.application.routes.draw do
  resources :products, only: :index
  resources :checkouts, only: %i[create destroy] do
    post :add, on: :member

    resources :items, only: :destroy
  end
end
